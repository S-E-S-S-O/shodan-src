require 'shodan'

def main

    key = "8lqVcIuzOahr1eJoD1fBBpWTBu0vAisG"
    user = Shodan::Shodan.new(key)   #My shodan api key
    
    puts """
█▀ █░█ █▀█ █▀▄ ▄▀█ █▄░█
▄█ █▀█ █▄█ █▄▀ █▀█ █░▀█  -By Lojacops   
█▀█ █▀▀ █▀ █▀▀ ▄▀█ █▀█ █▀▀ █░█
█▀▄ ██▄ ▄█ ██▄ █▀█ █▀▄ █▄▄ █▀█
"""
help = """
1) search results with only ip addresses
2) search results with infos (max 10)
3) get host infos by address 
4) show the api key
5) help (this)
6) exit
"""
print help
    begin
        prompt = "\rOption:"
        while (option = gets.chomp)
            if option == "1"
                Thread.new{
                    puts "\rSearch:"
                    search = gets.chomp
                    results = user.search("#{search}")

                    results["matches"].each do |host|
                        puts "\r[!] Address found: #{host["ip_str"]}"
                    end
                }.join
            end
            if option == "2"
                Thread.new{
                    puts "\rSearch:"
                    inputt = gets.chomp

                    result = user.count("#{inputt}", :facets => 'org:10')
                    puts "[!]Total number of results: #{result['total']}"
                    puts "[!]Maximum output: 10\n"
                    result.each do |outputt|
                        puts "\nOutput:"
                        puts result["facets"]
                    end
                }.join
            end
            if option == "3"
                Thread.new{
                    puts "\rAddress:"
                    inputtt = gets.chomp
                    output = user.host("#{inputtt}")
                    print output.to_s
                    puts "\n"
                }.join
            end
            if option == "4"
                puts "\rHere the API key:\n"
                puts "#{key}\n"
            elsif option == "5"
                print help
            elsif option == "6"
                puts "[+] Thanks for using!\n"
                break
            end
        system(option)
        print prompt
        end
    rescue => e
        puts "[+] ERROR"
    end
end

print main
