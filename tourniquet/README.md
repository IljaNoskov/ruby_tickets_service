# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

блокировка
curl -i -X PUT 'http://localhost:3010/api/tourniquets/block?' --data 'ticket_id=1&block=true&document=1'

вход
curl -i -X POST 'http://localhost:3010/api/tourniquets/input?' --data 'ticket_id=9&document=123&type_tourniquet=standart&event_id=1'

выход
curl -i -X POST 'http://localhost:3010/api/tourniquets/output?' --data 'ticket_id=9&document=123&type_tourniquet=standart&event_id=1'

просмотр журнала
curl -i -X GET 'http://localhost:3010/api/tourniquets/journal?' --data 'параметры по которым можно фильтровать'

фильтры:
optional :time_since - от какого времени в формате "2020-10-10"
optional :time_until - до какого времени в формате "2020-10-10"
optional :first_name - имя
optional :middle_name - отчество
optional :last_name - фамилия
optional :action - действие
optional :status - статус

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
