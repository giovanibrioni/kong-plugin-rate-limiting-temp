package = "kong-plugin-rate-limiting"
version = "3.3.1-1"

source = {
 url    = "",
 branch = "main"
}

description = {
  summary = "",
}

dependencies = {
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.rate-limiting.migrations"] = "kong/plugins/rate-limiting/migrations/init.lua",
    ["kong.plugins.rate-limiting.migrations.000_base_rate_limiting"] = "kong/plugins/rate-limiting/migrations/000_base_rate_limiting.lua",
    ["kong.plugins.rate-limiting.migrations.003_10_to_112"] = "kong/plugins/rate-limiting/migrations/003_10_to_112.lua",                  
    ["kong.plugins.rate-limiting.migrations.004_200_to_210"] = "kong/plugins/rate-limiting/migrations/004_200_to_210.lua",                
    ["kong.plugins.rate-limiting.expiration"] = "kong/plugins/rate-limiting/expiration.lua",                                              
    ["kong.plugins.rate-limiting.handler"] = "kong/plugins/rate-limiting/handler.lua",                                    
    ["kong.plugins.rate-limiting.schema"] = "kong/plugins/rate-limiting/schema.lua",                                      
    ["kong.plugins.rate-limiting.daos"] = "kong/plugins/rate-limiting/daos.lua",            
    ["kong.plugins.rate-limiting.policies"] = "kong/plugins/rate-limiting/policies/init.lua",
    ["kong.plugins.rate-limiting.policies.cluster"] = "kong/plugins/rate-limiting/policies/cluster.lua"

  }
}
