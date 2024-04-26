require_relative '../../exceptions/not_found.rb'

class GrapeApi
  class TourniquetsApi < Grape::API
    format :json
    namespace :tourniquets do

      namespace :journal do
        params do
          optional :time_since, type: Date 
          optional :time_until, type: Date
          optional :first_name, type: String
          optional :middle_name, type: String
          optional :last_name, type: String
          optional :action, type: String
          optional :status, type: String 
        end

        get do
          journal = Journal.all

          journal.where!('date >= :date_since', date_since: params[:date_since].to_time)if params[:date_since].present?
          journal.where!('date <= :date_until', date_until: params[:date_until].to_time)if params[:date_until].present?
          journal.where!({first_name: params[:first_name]})if params[:first_name].present?
          journal.where!({middle_name: params[:middle_name]})if params[:middle_name].present?
          journal.where!({last_name: params[:last_name]})if params[:last_name].present?
          journal.where!({action: params[:action]})if params[:action].present?
          journal.where!({status: params[:status]})if params[:status].present?

          present journal
        end
      end

      namespace :block do
        params do
          requires :ticket_id, type: Integer
          requires :block, type: Boolean
          requires :document, type: String
        end

        put do
          response = TicketBlockAdapter.new(ENV['PATH_TO_TICKET_BLOCK']).call(params[:ticket_id], params[:block], params[:document])
          present response
        end
      end

      namespace :input do
        params do
          requires :ticket_id, type: Integer
          requires :document, type: String
          requires :type_tourniquet, type: String
          requires :event_id, type: Integer
        end
    
        post do
          result = ValidateInputOutputService.validate(params)

          # проверить входит он или выходит
          visitor = Journal.where({ticket_id: params[:ticket_id], status: "successfully"}).last
          if visitor
            result['status'] = 'failed' if visitor[:action] == 'input'
          end

          Journal.create(ticket_id: params[:ticket_id],
                                    action: "input",
                                    status: result['status'],
                                    first_name: result['first_name'],
                                    middle_name: result['middle_name'],
                                    last_name: result['last_name'],
                                    date: Date.today)
                                    
          if result['status'] == 'successfully'
            present "Input successfully"
          else
            present "Input failed"
          end
        rescue NotFound
            present "Ticket or ticket holder not found"
        end
      end

      namespace :output do
        params do
          requires :ticket_id, type: Integer
          requires :document, type: String
          requires :type_tourniquet, type: String
          requires :event_id, type: Integer
        end
        post do
          result = ValidateInputOutputService.validate(params)
          # проверить входит он или выходит
          visitor = Journal.where({ticket_id: params[:ticket_id], status: "successfully"}).last
          if visitor
            result['status'] = 'failed' if visitor[:action] == 'output'
          else
            result['status'] = 'failed'
          end
        
          Journal.create(ticket_id: params[:ticket_id],
                                    action: "output",
                                    status: result['status'],
                                    first_name: result['first_name'],
                                    middle_name: result['middle_name'],
                                    last_name: result['last_name'],
                                    date: Date.today)

          if result['status'] == 'successfully'
            present "Output successfully"
          else
            present "Output failed"
          end
        rescue NotFound
          present "Ticket or ticket holder not found"
        end
      end
    end
  end
end