CarrierWave.configure do |config|
config.fog_credentials = {
    :provider                         => 'Google',
    :google_storage_access_key_id     => "GOOGXMOC54Z4UDW4NINO",
    :google_storage_secret_access_key => "d6Tp9ncHYiWqvpoOyr4zP+GmOR/wI8DgxEqEraau"
    }
    # production
    # config.fog_directory = 'aureso-product.appspot.com'
    # development
    config.fog_directory = 'dev-aureso.appspot.com'
end
