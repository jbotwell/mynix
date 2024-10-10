{
  memory.file_store = {};
  models = {
    csonnet = {
      type = "anthropic";
      chat_endpoint = "https://api.anthropic.com/v1/messages";
      model = "claude-3-5-sonnet-20240620";
      auth_token_env_var_name = "ANTHROPIC_API_KEY";
    };
  };
  chat = [
    {
      trigger = "!C";
      action_display_name = "Chat";
      model = "csonnet";
      parameters = {
        max_context = 4096;
        max_tokens = 1024;
        system = "You are a code assistant chatbot.";
      };
    }
  ];
}
