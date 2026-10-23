---
title: Skills of Agent
date: 2026‑02‑9
tags: [agent, skill, code, LLM]
cover: /images/blog/llm.png
excerpt: >
  How skill in LLM/agent framework is changing the game.
---

# What is skill

The rise of prompt engineering has always seemed too impractical to me. The idea that a few magic words could dramatically increase the quality of work produced by a black box just doesn’t strike me as very effective, especially when we are talking about code generation. 

But the release of __Skills__ changed my mind. After the publication of the concept of MCP (Model Context Protocol), Anthropic announced a novel approach in the world of LLMs — _Skills_. Unlike previous releases that aimed to build more complicated frameworks, the idea of _Skills_ seems almost too simple. It seeks to resolve a fundamental issue we encounter when working with LLMs: how to use fewer tokens to achieve the same results. __The idea behind Skills is to dismantle the prompt into modular components, link them through references, and invoke the relevant prompt only when needed dynamicly.__

<center>

![pic1](/images/blog/agentSkill.jpg  "pic1")
</center>

_Skills_ strike me as one of the most likely concepts to be widely accepted and endure in the AI era because they remind me of dependency management systems such as 'Maven, npm, Cargo, and pip'. While heavy reliance on dependency management has, in some cases, created cumbersome situations where even running a simple 'Hello, World' program requires installing hundreds of libraries, it has also enabled future developers to build on existing work.

One essential advantage of _Skills_ is that they are easy and safe to integrate into existing workflows, unlike _MCP_, where the cost of integration remains relatively high. Not to mention that MCP-based services have also posed significant security risks, as demonstrated by a series of incidents that have occurred since its introduction. _Skills_ on the other hand solve these issue by running completely locally. Ending all possible hijack from outside environment. The rise of prompt engineering has always seemed too impractical to me. The idea that a few magic words could dramatically increase the quality of work produced by a black box just doesn’t strike me as very effective, especially when we are talking about code generation. But _Skills_ may have changed this once and for all. For the first time, prompt engineering actually feels like engineering rather than a series of random experiments.

As a software developer, it feels like the first time I can truly make a difference and contribute meaningfully to this field. Before _Skills_, the AI era was largely dominated by data scientists and machine learning engineers. If you were not working at one of the top LLM firms like Google, OpenAI, or Anthropic, the only thing you could do was wait for the next major breakthrough.

_Skills_, however, shift part of that creative power back to developers. They introduce a layer where engineering discipline — modularization, abstraction, reuse, and composition — once again becomes central. Instead of passively adapting to model updates, developers can design structured capabilities, refine reusable components, and iteratively improve system behavior. In that sense, it feels less like waiting for the future to arrive and more like actively helping to build it.

What amazes me even more is that the ecosystem around _Skills_ has become a vibrant community. Not only are there offical plugin like CladeCode's [anthropics/skills](https://github.com/anthropics/skills), but also open source plugin targeting openClaw like [clawhub](https://github.com/openclaw/clawhub). All well worth exploring.


