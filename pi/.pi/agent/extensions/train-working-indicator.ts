import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import type { Component, TUI } from "@earendil-works/pi-tui";
import { visibleWidth } from "@earendil-works/pi-tui";

type UiTheme = {
	fg(color: "accent" | "dim" | "muted", text: string): string;
};

type Vehicle = {
	spriteFrames: string[];
	trailFrames: string[];
	trailWidth: number;
};

const INTERVAL_MS = 120;
const LEAD_FRAMES = 4;
const TAIL_FRAMES = 3;
const DEFAULT_TRAIL_WIDTH = 3;
const DEFAULT_TRAIL_FRAMES = ["   ", ".  ", "o. ", "Oo.", "oOo", ".oO", " .o", "  .", "   "];
const SCOOTER_TRAIL_FRAMES = ["   ", "'  ", ".. ", ".'.", " ..", "  '", "   "];
const MONSTER_CHASE_FRAMES = ["🏃  👹", "🏃 👹 ", "🏃👹  ", "🏃 👹 ", "🏃  👹"];
const TRACK_PATTERN = " ";

const VEHICLES: Vehicle[] = [
	vehicle("🚂"),
	vehicle("🚗"),
	vehicle("🚕"),
	vehicle("🚙"),
	vehicle("🚌"),
	vehicle("🚓"),
	vehicle("🚑"),
	vehicle("🚒"),
	vehicle("🚐"),
	vehicle("🛻"),
	vehicle("🚜"),
	vehicle("🛵", SCOOTER_TRAIL_FRAMES),
	{
		spriteFrames: MONSTER_CHASE_FRAMES,
		trailFrames: DEFAULT_TRAIL_FRAMES,
		trailWidth: DEFAULT_TRAIL_WIDTH,
	},
];

let previousVehicleIndex = -1;

function vehicle(
	sprite: string,
	trailFrames: string[] = DEFAULT_TRAIL_FRAMES,
	trailWidth: number = DEFAULT_TRAIL_WIDTH,
): Vehicle {
	return {
		spriteFrames: [sprite],
		trailFrames,
		trailWidth,
	};
}

function pickVehicle(): Vehicle {
	if (VEHICLES.length === 1) return VEHICLES[0]!;

	let index = Math.floor(Math.random() * VEHICLES.length);
	if (index === previousVehicleIndex) index = (index + 1) % VEHICLES.length;
	previousVehicleIndex = index;
	return VEHICLES[index]!;
}

function takeVisibleChars(text: string, maxWidth: number): string {
	let result = "";
	let width = 0;

	for (const char of text) {
		const charWidth = visibleWidth(char);
		if (width + charWidth > maxWidth) break;
		result += char;
		width += charWidth;
	}

	return result;
}

function track(width: number): string {
	if (width <= 0) return "";
	return TRACK_PATTERN.repeat(width);
}

class FullWidthVehicleIndicator implements Component {
	private frame = 0;
	private readonly timer: ReturnType<typeof setInterval>;
	private readonly spriteWidth: number;

	constructor(
		private readonly tui: TUI,
		private readonly theme: UiTheme,
		private readonly vehicle: Vehicle,
	) {
		this.spriteWidth = Math.max(...vehicle.spriteFrames.map((frame) => visibleWidth(frame)));
		this.timer = setInterval(() => {
			this.frame++;
			this.tui.requestRender();
		}, INTERVAL_MS);
	}

	render(width: number): string[] {
		if (width <= 0) return [""];

		const travelFrames = width + this.spriteWidth;
		const totalFrames = LEAD_FRAMES + travelFrames + TAIL_FRAMES;
		const frame = this.frame % totalFrames;

		if (frame < LEAD_FRAMES || frame >= LEAD_FRAMES + travelFrames) {
			return [this.theme.fg("dim", track(width))];
		}

		const vehicleFrame = frame - LEAD_FRAMES;
		const sprite = this.vehicle.spriteFrames[vehicleFrame % this.vehicle.spriteFrames.length] ?? "";
		const currentSpriteWidth = visibleWidth(sprite);
		const spriteColumn = width - this.spriteWidth - vehicleFrame;
		const trailFrame = this.vehicle.trailFrames[vehicleFrame % this.vehicle.trailFrames.length] ?? "   ";

		if (spriteColumn < 0) {
			const trail = takeVisibleChars(trailFrame, width);
			return [this.theme.fg("muted", trail) + this.theme.fg("dim", track(width - visibleWidth(trail)))];
		}

		const availableTrailWidth = Math.max(0, width - spriteColumn - currentSpriteWidth);
		const trail = takeVisibleChars(trailFrame, Math.min(this.vehicle.trailWidth, availableTrailWidth));
		const leftTrack = track(spriteColumn);
		const rightTrack = track(Math.max(0, width - spriteColumn - currentSpriteWidth - visibleWidth(trail)));

		return [
			this.theme.fg("dim", leftTrack) +
				this.theme.fg("accent", sprite) +
				this.theme.fg("muted", trail) +
				this.theme.fg("dim", rightTrack),
		];
	}

	invalidate(): void {}

	dispose(): void {
		clearInterval(this.timer);
	}
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", async (_event, ctx) => {
		ctx.ui.setWorkingIndicator({ frames: [] });
	});

	pi.on("agent_start", async (_event, ctx) => {
		const vehicle = pickVehicle();
		ctx.ui.setWorkingVisible(false);
		ctx.ui.setWidget(
			"train-working-indicator",
			(tui, theme) => new FullWidthVehicleIndicator(tui, theme, vehicle),
			{ placement: "belowEditor" },
		);
	});

	pi.on("agent_end", async (_event, ctx) => {
		ctx.ui.setWidget("train-working-indicator", undefined);
		ctx.ui.setWorkingVisible(true);
	});
}
