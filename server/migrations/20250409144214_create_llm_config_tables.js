exports.up=function(e){return Promise.all([e.schema.createTable("llm_providers",(t=>{t.string("provider_id").primary().notNullable(),t.string("name").notNullable(),t.string("default_model_id"),t.string("default_base_url"),t.boolean("requires_api_key").notNullable().defaultTo(!0),t.jsonb("metadata"),t.timestamp("created_at").defaultTo(e.fn.now()),t.timestamp("updated_at").defaultTo(e.fn.now())})),e.schema.createTable("llm_models",(t=>{t.string("model_id").primary().notNullable(),t.string("provider_id").notNullable().references("provider_id").inTable("llm_providers").onDelete("CASCADE"),t.string("name").notNullable(),t.integer("context_window").notNullable(),t.integer("max_output_tokens"),t.boolean("supports_images").notNullable().defaultTo(!1),t.boolean("supports_tool_use").notNullable().defaultTo(!1),t.boolean("supports_computer_use").defaultTo(!1),t.boolean("supports_prompt_cache").notNullable().defaultTo(!1),t.boolean("supports_thinking_tokens").defaultTo(!1).notNullable(),t.integer("recommended_thinking_tokens").nullable(),t.integer("max_thinking_tokens").nullable(),t.decimal("input_cost_per_million_tokens",10,4),t.decimal("output_cost_per_million_tokens",10,4),t.decimal("cache_writes_price",10,4),t.decimal("cache_reads_price",10,4),t.jsonb("metadata"),t.boolean("is_default_for_provider").defaultTo(!1),t.timestamp("created_at").defaultTo(e.fn.now()),t.timestamp("updated_at").defaultTo(e.fn.now())})),e.schema.createTable("agent_modes",(t=>{t.string("mode_id").primary().notNullable(),t.string("name").notNullable(),t.string("description"),t.string("default_provider_id").notNullable(),t.string("default_model_id"),t.integer("default_thinking_tokens"),t.string("default_base_url"),t.string("default_api_key_secret_name"),t.timestamp("created_at").defaultTo(e.fn.now()),t.timestamp("updated_at").defaultTo(e.fn.now())})),e.schema.createTable("user_llm_configurations",(t=>{t.increments("user_config_id").primary(),t.string("user_id").notNullable(),t.string("mode_id").notNullable().references("mode_id").inTable("agent_modes").onDelete("CASCADE"),t.string("provider_id").notNullable().references("provider_id").inTable("llm_providers").onDelete("CASCADE"),t.string("selected_model_id").references("model_id").inTable("llm_models").onDelete("SET NULL"),t.string("base_url"),t.integer("thinking_tokens"),t.text("api_key"),t.timestamp("last_used"),t.boolean("is_active_for_mode").notNullable().defaultTo(!1),t.timestamp("created_at").defaultTo(e.fn.now()),t.timestamp("updated_at").defaultTo(e.fn.now()),t.unique(["user_id","mode_id","provider_id"])}))])},exports.down=function(e){return Promise.all([e.schema.dropTableIfExists("user_llm_configurations"),e.schema.dropTableIfExists("agent_modes"),e.schema.dropTableIfExists("llm_models"),e.schema.dropTableIfExists("llm_providers")])};