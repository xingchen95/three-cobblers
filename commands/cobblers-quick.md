---
description: 三个臭皮匠 · Quick 模式 — 3 个 Opus 一次性 blind 作答后直接整合（无互评轮，更快更省）
argument-hint: <你的问题>
---
在下面的任务上以 **Quick 模式** 调用 **cobblers** skill（不走多轮 Discuss）。

执行流程：
1. **同一条消息** spawn **3 个独立 Opus 子代理**（`Agent`，`subagent_type: general-purpose`，`run_in_background: true`）。每个 prompt = 用户任务**逐字原文** + 简短指令：用 web/bash 自行研究、作为多位独立专家之一、不会看到他人回答、给完整自洽的中文答案。三份 prompt 完全相同，**不分配角色、不互看**。
2. 等三者全部返回。任一失败/超时 → 视为缺席，用其余继续并标注，绝不当作沉默同意；不足 2 份则说明并降级。
3. **整合**（不平均、不抹平冲突）：主窗口 Opus 输出 **共识 / 矛盾 / 部分覆盖 / 独特洞见 / 盲点 / 最终答案**。独立同意 = 最高置信；跑过代码或读过一手来源的权重更高。

不要进入互评/多轮（那是 `/cobblers`）。最终答案用中文。

Task: $ARGUMENTS
