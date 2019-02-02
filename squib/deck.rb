require 'squib'
require 'game_icons'
require 'yaml'

def buildAbilities(cardfile="cardfiles/abilities.csv", outputFile="abilities.pdf")
#All Ability Cards
data = Squib.csv file: cardfile
layouts = ['layouts/ability.yml', 'icons.yml']
icons =  YAML.load(File.read('icons.yml'))

Squib::Deck.new cards: data['name'].size, layout: layouts do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter
  text str: data['name'], layout: 'title'
  text str: data['text'].map { |text| text.gsub(/\\n/,"\n") }, layout: 'description'
  text str: data['type'], layout: 'type'
  svg file: data['name'].map {|x| x.downcase.gsub(/ /, "")}.map { |x| "../resources/images/cardart/abilities/#{x}.svg"}, layout: 'art'
  svg layout: data['icon']
  save_pdf trim: 37.5, file: outputFile
end
end

def buildEquipment(cardfile="cardfiles/equipment.csv", outputFile="equipment.pdf")
#All Equipment Cards
data = Squib.csv file: cardfile
layouts = ['layouts/equipment.yml', 'icons.yml']
icons =  YAML.load(File.read('icons.yml'))

Squib::Deck.new cards: data['name'].size, layout: layouts do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter
  text str: data['name'], layout: 'title'
  text str: data['text'], layout: 'description'
  text str: data['type'], layout: 'type'
  svg file: data['name'].map {|x| x.downcase.gsub(/ /, "")}.map { |x| "../resources/images/cardart/equipment/#{x}.svg"}, layout: 'art'
  svg layout: data['icon']
  save_pdf trim: 37.5, file: outputFile
end
end

def buildMonsters(cardfile="cardfiles/monsters.csv", outputFile="monsters.pdf")
#All Monster Cards
data = Squib.csv file: cardfile
layouts = ['hand.yml', 'layouts/monster.yml']

Squib::Deck.new cards: data['name'].size, layout: layouts do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter
  text str: data['name'], layout: 'title'
  text str: data['text'].map { |text| text.gsub(/\\n/,"\n") }, layout: 'monsterText', font: 'Sans 8'
  text str: data['name'], layout: 'art'
  svg file: GameIcons.get('hearts').file, layout: 'bonus1'
  text str: data['Health'], layout: 'bonus1Text'
  svg file: GameIcons.get('shield').file, layout: 'bonus2'
  text str: data['DR'], layout: 'bonus2Text'
  svg file: GameIcons.get('walking-boot').file, layout: 'bonus3'
  text str: data['Speed'], layout: 'bonus3Text'
  save_pdf trim: 37.5, file: outputFile
end
end