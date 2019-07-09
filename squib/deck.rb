require 'squib'
require 'game_icons'
require 'yaml'
require 'json'
require 'fileutils'
require 'set'
require 'pathname'

def buildManifest(manifestPath, compiledManifests)
  manifestPath = "#{manifestPath}/manifest.json"
  if(compiledManifests.include?(manifestPath))
    STDERR.puts("Attempting to compile manifest #{manifestPath} but it's already compiled")
    STDERR.puts("You may have either a cycle in the child graph, or two manifests are claiming the same child")
    return
  end

  compiledManifests.add(manifestPath)
  puts("Compiling manifest #{manifestPath}")
  manifestData = JSON.parse(File.read(manifestPath))

  if(manifestData["files"] != nil)
    directFilesToCompile = manifestData["files"]
    directFilesToCompile.each do |file|
      cardFilePath = getPathToChildOfManifest(manifestPath, file["name"])
      outputFilePath = cardFilePath.dup.sub!("cardfiles/", "").sub!(".csv", ".pdf")
      puts("Compiling #{cardFilePath} ==> #{outputFilePath}")
      buildFile(cardFilePath, outputFilePath, file["template"])
    end
  end

  if(manifestData["children"] != nil)
    childrenToCompile = manifestData["children"]
    childrenToCompile.each do |child|
      childFilePath = getPathToChildOfManifest(manifestPath, child)
      buildManifest(childFilePath, compiledManifests)
    end
  end
end

def getPathToChildOfManifest(manifestPath, childFile)
  manifestDirectory = File.dirname(manifestPath)
  return Pathname(File.join(manifestDirectory, childFile)).cleanpath.to_s
end

def buildFile(cardFile, outputFile, template)
  # Include _output for Squib
  FileUtils.mkdir_p(File.dirname("_output/#{outputFile}"))

  case template
  when "ability"
    buildAbilities(cardFile, outputFile)
  when "enemy"
    buildMonsters(cardFile, outputFile)
  when "equipment"
    buildEquipment(cardFile, outputFile)
  else
    puts("Unknown template type #{template} for file #{cardFile}; please review your manifests and update deck.rb if your template type should be supported and isn't")
  end
end

def buildAbilities(cardFile="cardFiles/abilities.csv", outputFile="abilities.pdf")
  #All Ability Cards
  data = Squib.csv file: cardFile
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
    text str: data['agi'], layout: 'agi'
    text str: data['klg'], layout: 'klg'
    text str: data['wil'], layout: 'wil'
    rect layout: 'str'
    rect layout: 'agi'
    rect layout: 'klg'
    rect layout: 'wil'
    svg file: data['name'].map {|x| x.downcase.gsub(/ /, "")}.map { |x| "../resources/images/cardart/abilities/#{x}.svg"}, layout: 'art'
    svg layout: data['icon']
    save_pdf trim: 37.5, file: outputFile
  end
end

def buildEquipment(cardFile="cardFiles/equipment.csv", outputFile="equipment.pdf")
  #All Equipment Cards
  data = Squib.csv file: cardFile
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

def buildMonsters(cardFile="cardFiles/monsters.csv", outputFile="monsters.pdf")
  #All Monster Cards
  data = Squib.csv file: cardFile
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