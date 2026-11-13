{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      model = "RU/gpt-5.4-mini";

      provider = {
        RU = {
          name = "RU";
          npm = "@ai-sdk/openai-compatible";

          options = {
            baseURL = "https://api.ai.cloud.ru.nl/v1";
            apiKey = "{env:RUAI_API_KEY}";
          };

          models = {
            "gpt-5.4-mini" = {
              name = "GPT-5.4 Mini";
              limit = {
                context = 128000;
                output = 16384;
              };
            };
          };
        };
      };
    };
  };
}
