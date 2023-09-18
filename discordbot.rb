require 'discordrb'
require 'dotenv'

Dotenv.load
bot = Discordrb::Bot.new token: ENV['DISCORD_BOT_TOKEN']

bot.message(with_text: 'Ping!') do |event|
    event.respond 'Pong!'
end

bot.message(with_text: '!plan') do |event|
    event.respond '1週間後までの予定は以下の通りです:'
end

bot.run