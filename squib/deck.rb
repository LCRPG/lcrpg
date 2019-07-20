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
  text str: data['str'], layout: 'str'
  text str: data['dex'], layout: 'dex'
  text str: data['int'], layout: 'int'
  text str: data['wil'], layout: 'wil'
  text str: data['fth'], layout: 'fth'
  text str: data['ocl'], layout: 'ocl'
  text str: data['arc'], layout: 'arc'
  text str: data['prm'], layout: 'prm'
  rect layout: 'str'
  rect layout: 'dex'
  rect layout: 'int'
  rect layout: 'wil'
  rect layout: 'fth'
  rect layout: 'ocl'
  rect layout: 'arc'
  rect layout: 'prm'
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

def buildCharacters(outputFile="characters.pdf")

layouts = ['layouts/character.yml']

Squib::Deck.new cards: 8, layout: layouts do
  background color: 'white'
  rect layout: 'cut'
  rect layout: 'safe'
  rect layout: 'art'
  line layout: 'name'
  text str: 'STR:', layout: 'str'
  text str: 'AGI:', layout: 'agi'
  text str: 'INT:', layout: 'int'
  text str: 'WIL:', layout: 'wil'
  text str: 'FTH:', layout: 'fth'
  text str: 'OCL:', layout: 'ocl'
  text str: 'ARC:', layout: 'arc'
  text str: 'PRM:', layout: 'prm'
  save_pdf trim: 37.5, file: outputFile
end
end
