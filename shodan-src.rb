require 'shodan'

def main

    key = "tbnPsiZDGrf3DfcffjbLyCNPvx1qI7iI"
    user = Shodan::Shodan.new(key)   #My shodan api key
    
    puts """
█▀ █░█ █▀█ █▀▄ ▄▀█ █▄░█
▄█ █▀█ █▄█ █▄▀ █▀█ █░▀█ 
█▀█ █▀▀ █▀ █▀▀ ▄▀█ █▀█ █▀▀ █░█
█▀▄ ██▄ ▄█ ██▄ █▀█ █▀▄ █▄▄ █▀█

"""
help = """
1) search results with only ip addresses
2) search results with infos (max 10)
3) get host infos by address 
4) show the api key
5) help (this)
6) exit\n
"""
    begin
        print help
        while true
            print "\rOption: "; option = gets.chomp
            case option
            when "1"
                print "\rSearch: "; search = gets.chomp
                results = user.search("#{search}")
                results["matches"].each do |host|
                    puts "\r[!] Address found: #{host["ip_str"]}"
                end
            when "2"
                print "\rSearch: "; inputt = gets.chomp
                result = user.search("#{inputt}", :facets => "org:10")
                puts "[!]Total number of results: #{result["total"]}"
                a = 0
                result["matches"].each do |sex|
                    a +=1
                    puts "\nOutput:"
                    puts "#{sex}".gsub(",",",\n")
                    if a >= 10
                        break
                    end
                end
            when "3"
                print "\rAddress:"; inputtt = gets.chomp
                output = user.host("#{inputtt}")
                print output.to_s + "\n"
            when "4"
                puts "\rHere the API key:\n#{key}\n"
            when "5"
                print help
            when "6"
                puts "[+] Thanks for using!\n"
                break; exit
            end
        end
    rescue => e
        puts "[+] ERROR\n#{e}"
    end
end

print main
