# Ethereum Shop
Simple e-commerce app in solidity language

## Basic idea

The contract implements simple webshop, where items are created by the owner and they can be
transferred to another user by the owner only

## Simple use case

Owner of the shop creates a website that talks with the ethereum node through [ethereum js api](https://github.com/ethereum/web3.js/) then add items through
the contract and displays the item on the website

A user creates an account on the website, enters his address of the ethereum wallet,
then through the website orders some coins, at which point the server invokes the buy coin with user's wallet address.

Once a user acquires tokens, they can be used to buy items, at which point the website issues transferItem method call
on the contract and transfers item possession the user
