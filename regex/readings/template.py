import re

#Extract american Phone number from different formats
# .? 0 or 1 character to account for the optional open parenthesis
# (\\d{3}) 3 digit characters (first capture group i.e. first 3 digits)
# .* 0 or more characters to account for the optional closing parenthesis, hyphen, and space characters
# (\\d{3}) 3 digit characters (second capture group i.e. next 3 digits)
# .* 0 or more characters to account for the optional hyphen and space characters
# (\\d{4}) 4 digit characters (third capture group i.e. last 4 digits)
phone_pattern = ".?(\\d{3}).*(\\d{3}).*(\\d{4})"
txt = "9704443106" # (541) 741 3918, (603)281-0308, (814)-462-8074, 9704443106

phone = re.findall(phone_pattern, txt)

if phone:
  print("Phone Number Components: ")
  print(*phone)
else:
  print("No match")

#Extract Date from different Formats
date_pattern = ""
txt = "20-02-2019" # 20-02-2019, 15/07/2020, 14.09.2021
date = re.findall(date_pattern, txt)

if date:
  print("Date Components: ")
  print(*date)
else:
  print("No match")

#Extract Names from different formats

name_pattern = ""
txt = "Smith, Mr. John" #Smith, Mr. John; Davis, Ms Nicole; Robinsion, Mrs. Rebeccca; Armstrong, Dr Sam; Downey, Mr. Robert;
name = re.findall(name_pattern, txt)
if name:
  print("Name Components: ")
  print(*name)
else:
  print("No match")

#Extract URL Components
url_pattern = "(https?)://(www)?.?(\\w+).(\\w+)/?(\\w+)?"
txt = "https://twitter.com/home" #https://www.google.com/gmail, http://heise.de, https://twitter.com/home
url = re.findall(url_pattern, txt)
if url:
  print("URL Components: ")
  print(*url)
else:
  print("No match")

#Extract Email Adresss Components
# ([a-zA-Z0-9\\_\\-\\.]+) 1 or more lowercase letters, uppercase letters, digits, and special characters including underscore, hyphen, and full stop (first capture group i.e. username)
# @ at symbol
# ([a-zA-Z]+) 1 or more lowercase and uppercase letters (second capture group i.e. domain name)
# . a single full stop character
# (.+) 1 or more characters (third capture group i.e. domain)
email_pattern = "([a-zA-Z0-9\\_\\-\\.]+)@([a-zA-Z]+).(.+)"
txt = "johndoe@hotmail.com" #johndoe@hotmail.com, jason-smith@uni.gov.co, xrlab@hs-harz.de
email = re.findall(email_pattern, txt)
if email:
  print("eMail Components: ")
  print(*email)
else:
  print("No match")

# Extract Address Components
# (\\d*) 0 or more digit characters because some addresses do not have house numbers (first capture group i.e. house number)
# \\s? 0 or 1 whitespace character
# (.+) 1 or more characters (second capture group i.e. street name)
# , comma
# \\s a single whitespace character
# (.+) 1 or more characters (third capture group i.e. suburb)
# \\s a single whitespace character
# ([A-Z]{2,3}) 2 or 3 uppercase letters (fourth capture group i.e. state)
# \\s a single whitespace character
# (\\d{4}) 4 digit characters (fifth capture group i.e. postcode)
address_pattern = "(\\d*)\\s?(.+),\\s(.+)\\s([A-Z]{2,3})\\s(\\d{4})"
txt = "21 Bungana Drive, Kybunga SA 5453" # 21 Bungana Drive, Kybunga SA 5453; Thomas Lane, Fitzroy North VIC 3068; 107 Quayside Vista, Kingston ACT 2604; 94 Prince Street, Lower Coldstream NSW 2460
address = re.findall(address_pattern, txt)
if address:
  print("Address Components: ")
  print(*address)
else:
  print("No match")

#Search in a List

mylist = ["Hund", "Katze", "Maus", "Wildkatze", "Seekuh", "Wollmaus", "Katzenfutter"]
r = re.compile("INSERT REGEX HERE", re.IGNORECASE) # add flag to ignore case
newlist = list(filter(r.match, mylist))
print(newlist)

#Greedy vs. Lazy
test_pattern = "<.+?>" #"<.+>" vs "<.+?>"
txt = "<body>\n<h1>test</h1>\n<hr />\n<h2>Text</h2>\n</body>"
matches = re.findall(test_pattern, txt,re.IGNORECASE)
if matches:
  print("Matches: ")
  print(matches)
else:
  print("No match")