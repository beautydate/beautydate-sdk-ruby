# Beautydate API v2 Client

## Definindo a chave de acesso a API do Beauty Date
```ruby
BeautydateApi.api_key = 'API_KEY'
BeautydateApi.api_email = 'API_EMAIL'
BeautydateApi.api_password = 'API_PASSWORD'
```

### Business
Interagindo com os endpoints de Business.

#### Recuperando dados de um Business
```ruby
business = BeautydateApi::Business.new
business.id = 103
business.refresh
```

#### Atualizando dados de um Business
```ruby
business = BeautydateApi::Business.new
business.id = 103
business.refresh
business.az_id = 16
business.update
```

#### Criando um Business API
```ruby
business = BeautydateApi::Business.new
business.create(name: 'Nome Comercial', businesstype: 'Salão de Beleza', zipcode: '80440-050', street: 'Rua Carmelo Rangel', street_number: '500', neighborhood: 'Batel', city: 'Curitiba', state: 'PR', phone: '4130289290', description: '', az_id: '')
```

#### Adicionando dias de Trial
```ruby
business = BeautydateApi::Business.new
business.id = 103
business.add_trial_days 10
```

#### Ativando ou inativando o pagamento manual
```ruby
business = BeautydateApi::Business.new
business.id = 103
business.manual_payment true
```

#### Avisando sobre o pagamento
```ruby
payment = BeautydateApi::BusinessPayment.new
payment.create(paid_with: 'debit', transaction_details: {}, business_id: 1, business_plan_id: 1)
```

This project rocks and uses MIT-LICENSE.
