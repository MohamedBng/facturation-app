json.extract! client, :id, :nom_complet, :adresse, :ville, :code_postal, :num_siret, :created_at, :updated_at
json.url client_url(client, format: :json)
