require 'discordrb'
require 'dotenv'
require 'notion-ruby-client'

Dotenv.load
bot = Discordrb::Bot.new token: ENV['DISCORD_BOT_TOKEN']
client = Notion::Client.new(token: ENV['NOTION_API'])

bot.message(with_text: '!ping') do |event|
    event.respond 'pong!'
end

bot.message(with_text: '!event') do |event|
    event.respond '1週間後までの予定は以下の通りです:'
    
    
    sorts = [
        {
            property: '日付',
            direction: 'ascending'
        }
    ]

    # 今から一週間後までの予定だけを取得する
    filter = {
        'and': [
            {
                property: '日付',
        
                date: {
                    on_or_after: Date.today,
                }
            },
            {
                property: '日付',
                date: {
                    on_or_before: Date.today + 7,
                }
            }
        ]
    }

    page = client.database_query(database_id: ENV['DB_ID'], filter: filter, sorts: sorts)

    page.results.each do |result|
        event.respond "."
        date = result.properties['日付'].date.start
        name = result.properties['名前'].title[0].plain_text
        event.respond "#{date}: #{name}"
    end
    

end

bot.run