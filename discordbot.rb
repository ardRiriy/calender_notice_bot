require 'discordrb'
require 'dotenv'
require 'notion-ruby-client'

Dotenv.load
bot = Discordrb::Bot.new token: ENV['DISCORD_BOT_TOKEN']
client = Notion::Client.new(token: ENV['NOTION_API'])

bot.message(with_text: 'Ping!') do |event|
    event.respond 'Pong!'
end

bot.message(with_text: '!plan') do |event|
    # event.respond '1週間後までの予定は以下の通りです:'
    page = client.database_query(database_id: ENV['DB_ID'])
        # paginate through all pages
    page.results.each do |result|
        event.respond result.properties['名前'].title[0].plain_text
        event.respond "------------------"
    end
    

end

bot.run