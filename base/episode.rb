# IMPORTANT: DO NOT MODIFY THIS FILE.
# To complete this assignment you only need to modify
# the files inside the individual /episode-xx/ folders.
# You may, however, take a look inside this file to see
# how the entire program works. Ideally though, you'll
# only need to work with the files inside the individual
# /episode-xx/ folders to fix the replicator each episode.

class Episode

  EPISODE_NUMBERS = Dir.glob("episode-*").map {|folder| folder[/\d+$/] }

  attr_reader :number, :title, :star, :recipe, :lines

  def initialize(number)

    if EPISODE_NUMBERS.include?(number)
      episode = JSON.parse(File.read("episode-#{number}/episode.json"))
      @number = number
      @title  = episode['title']
      @star   = episode['star']
      @recipe = Recipe.new(episode['recipe'])
      @lines  = episode['lines'] || {}
      @lines.merge!(default_lines) { | key, custom_line, default_line | custom_line }
    else
      App.display_help_and_exit
    end

  end

  def default_lines
    {
      replicator_command:                        "Computer, make me a #{@recipe.name}  please.",
      anticipating_replicator_creation:          'looks at the replicator plate and says',
      responding_to_replicator_creation_success: "Now that's a good #{@recipe.name}!",
      move_on_to_next_episode:                   'Congratulations! You may now move on to the next episode.',
      responding_to_nothing_on_replicator_plate: "There's nothing there!",
      responding_to_replicator_creation_failure: "That's not a #{@recipe.name}!",
      fix_replicator_request:                    'Fix this replicator please!'
    }
  end

end
