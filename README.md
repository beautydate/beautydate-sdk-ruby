# Beautydate API v2 Client

# Definindo o CONSUMER KEY de acesso a API do Beauty Date
BeautydateApi.api_key = 'API_KEY'

# Business
business = BeautydateApi::Business.new

## Recuperando dados de um Business
business.id = 103
business.refresh

## Atualizando dados de um Business
business.id = 103
business.refresh
business.az_id = 16
business.update

## Criando um Business API
business.create {commercial_name: 'Nome Comercial', type: 'Salão de Beleza', zipcode: '80440-050', street: 'Rua Carmelo Rangel', street_number: '500', neighborhood: 'Batel', city: 'Curitiba', state: 'PR', phone: '4130289290', description: '', az_id: ''}

## Adicionando dias de Trial
business.id = 103
business.add_trial_days 10

## Ativando ou inativando o pagamento manual
business.id = 103
business.manual_payment true


This project rocks and uses MIT-LICENSE.