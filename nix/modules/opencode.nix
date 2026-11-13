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
            "gpt-5-mini" = {
              name = "GPT-5 Mini";
              limit = {
                context = 128000;
                output = 16384;
              };
            };
            "gpt-5.4-mini" = {
              name = "GPT-5.4 Mini";
              limit = {
                context = 128000;
                output = 16384;
              };
            };
            "mistral-large" = {
              name = "Mistral Large 3";
              limit = {
                context = 128000;
                output = 16384;
              };
            };
            "deepseek-v4-flash" = {
              name = "Deepseek v4 flash";
              limit = {
                context = 256000;
                output = 32768;
              };
            };
            "gpt-6.1-sol" = {
              name = "GPT-6.1 Sol";
              limit = {
                context = 256000;
                output = 32768;
              };
            };
          };
        };
      };
    };
  };
}
