import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";

/**
 * Runs `jj new` before every turn so each turn starts on a fresh jj
 * working-copy change.
 *
 * - Not inside a jj repo  -> swallow the error silently.
 * - Any other jj failure  -> warn the user, but never block the turn.
 *
 * `turn_start` handlers cannot block execution (no blocking return type), so
 * this is observational by construction: the turn proceeds regardless.
 */
export default function jjNew(pi: ExtensionAPI): void {
	pi.on("turn_start", async (_event, ctx) => {
		let result;
		try {
			result = await pi.exec("jj", ["new"], { cwd: ctx.cwd });
		} catch (err) {
			// jj binary missing or spawn failure: warn, don't interrupt.
			ctx.ui.notify(`jj new failed to run: ${String(err)}`, "warning");
			return;
		}

		if (result.code === 0) return;

		// Outside a jj repo: expected, swallow silently.
		if (/no jj repo/i.test(result.stderr)) return;

		const detail = (result.stderr || result.stdout).trim();
		ctx.ui.notify(
			`jj new failed (exit ${result.code})${detail ? `: ${detail}` : ""}`,
			"warning",
		);
	});
}
