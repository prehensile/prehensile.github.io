---
layout: post
title:  "I Am Running In The Cloud"
date:   2018-02-17 22:54:00
categories: blog
---

> I am sitting in a room different from the one you are in now. I am recording the sound of my speaking voice and I am going to play it back into the room again and again until the resonant frequencies of the room reinforce themselves so that any semblance of my speech, with perhaps the exception of rhythm, is destroyed. What you will hear, then, are the natural resonant frequencies of the room articulated by speech. I regard this activity not so much as a demonstration of a physical fact, but more as a way to smooth out any irregularities my speech might have.

— Alvin Lucier, [*I am sitting in a room*](https://en.wikipedia.org/wiki/I_Am_Sitting_in_a_Room), 1969

At the end of 2017, [Tim Cowlishaw](http://www.timcowlishaw.co.uk/) and I had a few conversations with folk that started us off thinking about Amazon Echo (and things like it — voice devices / 'smart speakers' in general) as experimental sound objects. Not necessarily thinking about the voice-controlled aspects of them as the potential they offer as a decent speaker, backed by some computing power and connected to a network.

[The first experiment we made](https://www.youtube.com/watch?v=zymfLZzLPXc&t=124s) was a reworking of [inbflat.net](http://inbflat.net), using a room full of Echoes to play parts of the piece. There's a reference to Janet Cardiff's [Forty Part Motet](http://www.cardiffmiller.com/artworks/inst/motet.html) there too, one of the most affecting and beautiful sound art pieces I've seen in recent years.

Meanwhile, Tim was riffing on Alvin Lucier's _I am sitting in a room_. Lucier made the piece in 1969 by recording himself reciting a text, and then playing back the tape into a room and recording the room sound on another tape deck. He repeated this process over and over again, until the generation loss and cumulative room sound completely destroyed the sound of his voice.

Brilliantly, the text was a description of this process, quoted above. He described what he was going to do, how it was going to work and then the act of carrying out his stated intent destroyed the sense in the recording. As programmers and sound nerds, we were both really attracted to the self-reflexive, inwardly-curling nature of the piece.

So, our loose idea was to have two voice devices repeat Lucier's original text to each other, amplifying and compounding small errors in their speech-to-text systems by speaking the text out loud and repeating what they'd transcribed. The quirks and biases of the complex natural langauge processing systems at work in these devices would be revealed by the errors that crept in through repetition, the byzantine pathways of their networked operations replacing the Lucier's original room and tape decks.

Unfortunately, the market-dominant voice devices just don't work like that. They're built to remove error, from the noise reduction in their always-on microphone arrays to the statistical models of language that conform input speech to the closest 'correct' interpretation for a given application. This is why VUI applications tend to have very limited vocabularies - it's much easier for a system to disambiguate what a user's said if the list of possibilities is small.

Tim manged to [simulate](https://gist.github.com/timcowlishaw/2d8917ff1b471ec4317b7c188bdd3f44) the kind of loop we wanted outside of a VUI system, but if we were going to make a piece for voice devices, we needed to contrive a source of errors. 

Which made me think of [*Oulipo S+7*](https://en.wikipedia.org/wiki/Oulipo#Constraints). 

I first came across S+7 on Ross Sutherland's excellent podcast [Imaginary Advice](https://www.imaginaryadvice.com/). The [particular episode](https://soundcloud.com/ross-sutherland/32-jerusalem-7) I'm thinking of was a recording of a collaboration between Sutherland and Matthew Kaner, where Sutherland had rewritten Jerusalem using a writing technique where nouns and verbs in the original text are replaced by words a few steps removed in the dictionary. *Room* becomes *Roosevelt* and so on. The technique is named *Oulipo S+7* after the French-speaking group of writers and mathematicians who devised it in the 1960s.

I immediately liked the language glitches introduced by S+7 — they reminded me of generative language experiments I've known and loved in the past, during my time messing about with Twitter bots. 

So I [implemented](https://gist.github.com/prehensile/7d5eb1e79bd4476dee90ab51efb34bc8) S+7 in Python, and wrote a 'skill' for Alexa which would repeat Lucier's text with the nouns offset. I also set up the skill so that it would speak out loud the invocation for another Echo device to read the next iteration of the text when it had finished its recital.

At this point, we had a loop of two devices talking to one another and some nice cumulative errors creeping in. However, using Lucier's original text wasn't satisfying at all. In fact, it felt wrong. Lucier's words referred to his process in creating his original artwork; the piece we were making was a different process for a different piece. Inspired by (ripping off) Lucier's work, sure, but not the same. It became clear to me that I needed to write new words to reflect the piece we were making and the process it would enact. 

As I started to do this, though, I ran into a wall. I couldn't decide whether to write this from my point of view ('I am writing code') or the point of view of Alexa-trapped-in-Echo ('I am running in the cloud'). Lucier hadn't had this problem! Since he was speaking his own words, he was simultaneously the writer, performer and subject of the text. For me, these three had become separated by the technology.

The answer popped into my head while I was having a swim. Since we were using two devices in conversation, I could write both points of view, one for each device! This made the piece more interesting anyway, since I could explore the disjoints between the two constructed personalities by putting them into dialogue and have them both dissolve each other into meaninglessness through repetition and iteration. Lovely. [Both texts](https://raw.githubusercontent.com/prehensile/alexa-sittingroom/master/texts.txt) are available [in the project's github repository](https://github.com/prehensile/alexa-sittingroom).

Here's a video of it iterating away:

[![Watch I Am Running In The Cloud on Youtube](https://img.youtube.com/vi/TGmrltCuTZQ/0.jpg)](https://www.youtube.com/watch?v=TGmrltCuTZQ)

*Why the different voices, Henry?* I'm glad you asked. I think it's disingenuous for voice assistants to give the impression of having a coherent, intelligent personality when the thing that talks to you is a patchwork of many complex systems, all running in server farms far away. The device sat in your room is not the assistant - it's the business end of a very large, very complex networked iceberg. I also think that it's a problem that the personality these things pretend to have is bland, subservient, coded 'female' - a stereotype of a 1950s secretary in a box. This is why I like to make things that speak with many voices for these devices - a truer reflection of the herd of processes running things behind the scenes, and less bound to a particular false personality.

I use [Amazon Polly](https://aws.amazon.com/documentation/polly/) to synthesize these many voices, which is not the most straightforward to use on the fly. Thus, a nice offshoot of this project has been the [polly-s3](https://www.npmjs.com/package/polly-s3) module I wrote for node.js, which makes it easier to use in dynamic voice applications.

