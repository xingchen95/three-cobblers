---
description: 三个臭皮匠 · Discuss 模式 — 3 个 Opus 多轮讨论（首轮 blind 独立 + 互评轮加角色），主窗口 Opus 整合；--full/--digest 控制互评上下文
argument-hint: "[--full|--digest] <你的问题>"
---
在下面的任务上以 **Discuss 模式** 调用 **cobblers** skill（照 `skills/cobblers/references/discuss.md`，角色见 `references/roles.md`）。

**先解析上下文模式**：`$ARGUMENTS` 含 `--full` → **full**（互评轮转发另两家完整 Round 1 全文，最完整、token 更高）；含 `--digest` 或不指定 → **digest**（默认，转发各家自产的「自述卡」，省 token、保真）。把标志从问题文本里剥掉再用。

执行流程：
1. **Round 1（blind 独立）**：同一条消息 spawn **3 个独立 Opus 子代理**（`Agent`，`subagent_type: general-purpose`，`run_in_background: true`，prompt = 用户任务**逐字原文** + 简短指令，**不分配角色**），各自用 web/bash 研究、给完整自洽的中文答案，并在结尾附结构化**「自述卡」**（核心主张 / 关键证据与来源 / 关键假设 / 待验证）。等三者返回。
2. **Round 2（互评轮）**：用 `SendMessage` 把**另两家**的信息喂回每个子代理——**digest 转「自述卡」、full 转完整全文**——并按 spawn 顺序分派 **严谨者 / 发散者 / 批判者** 角色，要求互评：保留/修正/放弃 + 为什么、最强反例、证据缺口、最低成本验证，并更新自己的「自述卡」。三个 `SendMessage` 同一条消息并发。等三者返回。
3. **收敛**：主窗口自行判断；仍有重大分歧且未到上限可发起 Round 3（只聚焦分歧点，沿用同一上下文模式）。**轮数硬上限 2 轮，最多 3 轮。**
4. **整合**：主窗口 Opus 输出 **共识 / 矛盾 / 部分覆盖 / 独特洞见 / 盲点 / 观点演化 / 最终答案**，保留分歧不强压共识，并注明本次上下文模式（digest / full）。

某子代理失败 → 视为该轮缺席，用其余两家继续并标注，绝不当作沉默同意。最终答案用中文。

Task: $ARGUMENTS
