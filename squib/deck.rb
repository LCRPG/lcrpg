require 'squib'
require 'game_icons'
require 'yaml'


data = Squib.csv file: "cards.csv"
layouts = ['fantasy.yml', 'icons.yml']
icons =  YAML.load(File.read('icons.yml'))

Squib::Deck.new cards: data['name'].size, layout: layouts do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter
  text str: data['name'], layout: 'title'
  text str: data['text'], layout: 'description'
  text str: data['type'], layout: 'type'
  svg file: data['art'].map { |x| GameIcons.get(x).file}, layout: 'art'
  svg file: data['icon'].map { |x| GameIcons.get(icons[x]['file']).file }, layout: data['icon']
  save_png
  save_pdf trim: 37.5
end