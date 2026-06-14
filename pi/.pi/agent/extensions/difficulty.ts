import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { Key, Text } from "@earendil-works/pi-tui";

type DifficultyName = "easy" | "medium" | "hard" | "extreme";
type ThinkingLevel = "off" | "minimal" | "low" | "medium" | "high" | "xhigh";
type WidgetColor = "success" | "warning" | "error";

interface DifficultyLevel {
	provider: string;
	model: string;
	modelName: string;
	thinkingLevel: ThinkingLevel;
	widgetColor?: WidgetColor;
}

const LEVELS: Record<DifficultyName, DifficultyLevel> = {
	easy: {
		provider: "anthropic-proxy",
		model: "anthropic.claude-haiku-4-5-20251001-v1:0",
		modelName: "Haiku 4.5",
		thinkingLevel: "off",
		widgetColor: "success",
	},
	medium: {
		provider: "anthropic-proxy",
		model: "anthropic.claude-sonnet-4-6",
		modelName: "Sonnet 4.6",
		thinkingLevel: "low",
		widgetColor: "warning",
	},
	hard: {
		provider: "anthropic-proxy",
		model: "anthropic.claude-opus-4-6-v1",
		modelName: "Opus 4.6",
		thinkingLevel: "medium",
	},
	extreme: {
		provider: "github-copilot",
		model: "gpt-5.5",
		modelName: "gpt-5.5",
		thinkingLevel: "high",
		widgetColor: "error",
	},
};

const CYCLE: DifficultyName[] = ["easy", "medium", "hard"];

export default function difficultyExtension(pi: ExtensionAPI) {
	let activeDifficulty: DifficultyName | undefined;
	let selfTriggeredModelChange = false;

	function updateWidget(ctx: ExtensionContext) {
		if (!activeDifficulty || activeDifficulty === "hard") {
			ctx.ui.setWidget("difficulty", undefined);
			return;
		}

		const level = LEVELS[activeDifficulty];
		if (!level.widgetColor) {
			ctx.ui.setWidget("difficulty", undefined);
			return;
		}

		const text = `${activeDifficulty.toUpperCase()} — ${level.modelName}`;
		ctx.ui.setWidget("difficulty", (_tui, theme) => new Text(theme.fg(level.widgetColor!, text), 0, 0));
	}

	async function applyDifficulty(name: DifficultyName, ctx: ExtensionContext): Promise<boolean> {
		const level = LEVELS[name];
		const model = ctx.modelRegistry.find(level.provider, level.model);

		if (!model) {
			ctx.ui.notify(`Difficulty "${name}": model ${level.provider}/${level.model} not found`, "error");
			return false;
		}

		selfTriggeredModelChange = true;
		const success = await pi.setModel(model);

		if (!success) {
			selfTriggeredModelChange = false;
			ctx.ui.notify(`Difficulty "${name}": no API key for ${level.provider}/${level.model}`, "error");
			return false;
		}

		// If setModel did not emit model_select (for example, re-selecting the current model),
		// avoid leaving a stale self-trigger flag that would hide the next external change.
		if (selfTriggeredModelChange) {
			selfTriggeredModelChange = false;
		}

		pi.setThinkingLevel(level.thinkingLevel);
		activeDifficulty = name;
		updateWidget(ctx);
		return true;
	}

	for (const name of Object.keys(LEVELS) as DifficultyName[]) {
		pi.registerCommand(name, {
			description: `Switch to ${name} difficulty`,
			handler: async (_args, ctx) => {
				await applyDifficulty(name, ctx);
			},
		});
	}

	pi.registerShortcut(Key.ctrlShift("e"), {
		description: "Cycle difficulty (easy → medium → hard)",
		handler: async (ctx) => {
			let nextIndex: number;

			if (!activeDifficulty || activeDifficulty === "hard" || activeDifficulty === "extreme") {
				nextIndex = 0;
			} else {
				const currentIndex = CYCLE.indexOf(activeDifficulty);
				nextIndex = currentIndex === -1 ? 0 : (currentIndex + 1) % CYCLE.length;
			}

			await applyDifficulty(CYCLE[nextIndex], ctx);
		},
	});

	pi.on("model_select", async (_event, ctx) => {
		if (selfTriggeredModelChange) {
			selfTriggeredModelChange = false;
			return;
		}

		activeDifficulty = undefined;
		ctx.ui.setWidget("difficulty", undefined);
	});
}
