---
title: How to Build Your Own Server
date: 2025‑06‑05
tags: [linux, nginx, dev‑ops]
cover: /images/blog/_a.jpg   # optional hero image
excerpt: >
  A guide to turn an computer into a Ubuntu server with Nginx.
---

# How to Build Your Own Server
![pic1](/images/blog/_a.jpg  "Title")


Building a personal server has always been one of those project I know I will get on to someday but just don't have the time for it. At the start of this summer, I finially decided to get on to it. The process is a bit taunting if you never experienced working with a server. But trust me, it is not as difficult as you might have thought.


## What do I need?

1. One always running **Laptop/Desktop** with stable network connection. The Operation System does not matter here because we will be using Linux.

2. One empty **USB drive** for installing Linux.

And that is all you need! Yes, you heard me right. No need to rent a expensive cloud server and paying monthly subscription. As long as you have a computer with stable network connection you can make your very own always running personal website up and running!

## Setup

First and formost, remember to back up the important files on your computer. Once we install the server OS on the computer, we are also formating all files in that computer, so parepare in advance. The computer we choose to host our server doesn't have to be a super powerful one. Considering most personal website are static and doesn't crazy animation/interaction, a used machaine from couple of years ago or that old laptop you replaced with the newest Macbook will do the trick.

For me, I am using a 2014 Mac-mini that I found in the facebook market with only $40 - a worthy investment. 

![pic2](/images/blog/_b.jpg  "pic2")

Next, we will need to download the Server OS. In this article, we will be using the Ubuntu release. Head to the [Ubuntu Official Website](https://ubuntu.com/download/server/). The Ubuntu 24.04.2 LTS is the latest version at the time of writing this article so let us just download that. Here LTS stand for long-term-support but honestly the latest version with nine months security support would be no different.

You will need some program to burn the iso file into the usb drive. Here I am using Rufus. There are plenty of options for this step like Unetbootin, Popsicle, Windows USB/DVD Download Tool, RMPrepUSB, Yumi, UUByte ISO Burner, or Wintoflash. Any of them would do the trick.

![pic3](/images/blog/_b.jpg  "pic3")

## Installation

After we burn the iso file into the USB drive, we can then start our installation. Head to your computer. Plug the bootable usb drive into the computer and restart your computer. 

1. For Mac, you will need to press and hold **Command (⌘)** and **R** keys while powering on, releasing them when you see the Apple logo or a spinning globe. 

2. For Windows, hold down the **Shift key** while restarting from the Start menu or by holding it down during startup when prompted.


