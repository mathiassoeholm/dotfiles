import type {
  AssistantMessageEventStream,
  Context,
  Model,
  SimpleStreamOptions,
} from "@mariozechner/pi-ai";
import { streamSimpleAnthropic } from "@mariozechner/pi-ai";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

function streamLegoAnthropic(
  model: Model<"anthropic-messages">,
  context: Context,
  options?: SimpleStreamOptions,
): AssistantMessageEventStream {
  const patchedOptions: SimpleStreamOptions = {
    ...options,
    reasoning: options?.reasoning || "low",
    onPayload: (payload: any) => {
      // LEGO proxy requires temperature=1 when thinking is enabled
      payload.temperature = 1;
      return options?.onPayload?.(payload) ?? payload;
    },
  };
  return streamSimpleAnthropic(model, context, patchedOptions);
}

export default function (pi: ExtensionAPI) {
  pi.registerProvider("lego-anthropic", {
    name: "LEGO Anthropic",
    baseUrl: "https://models.assistant.legogroup.io/anthropic",
    api: "anthropic-messages",
    apiKey: "ANTHROPIC_AUTH_TOKEN",
    headers: {
      "api-key": "ANTHROPIC_AUTH_TOKEN",
    },
    streamSimple: streamLegoAnthropic as any,
    models: [
      {
        id: "anthropic.claude-sonnet-4-6",
        name: "LEGO Sonnet 4.6",
        reasoning: true,
        input: ["text", "image"],
        contextWindow: 200000,
        maxTokens: 64000,
        cost: { input: 3, output: 15, cacheRead: 0.3, cacheWrite: 3.75 },
        thinkingLevelMap: { off: null },
        compat: { forceAdaptiveThinking: true },
      },
      {
        id: "anthropic.claude-opus-4-6-v1",
        name: "LEGO Opus 4.6",
        reasoning: true,
        input: ["text", "image"],
        contextWindow: 200000,
        maxTokens: 64000,
        cost: { input: 15, output: 75, cacheRead: 1.5, cacheWrite: 18.75 },
        thinkingLevelMap: { off: null },
        compat: { forceAdaptiveThinking: true },
      },
      {
        id: "anthropic.claude-haiku-4-5-20251001-v1:0",
        name: "LEGO Haiku 4.5",
        reasoning: true,
        input: ["text", "image"],
        contextWindow: 200000,
        maxTokens: 64000,
        cost: { input: 0.8, output: 4, cacheRead: 0.08, cacheWrite: 1 },
        thinkingLevelMap: { off: null },
        compat: { forceAdaptiveThinking: true },
      },
    ],
  });
}
