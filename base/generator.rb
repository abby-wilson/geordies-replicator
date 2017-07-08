# IMPORTANT: DO NOT MODIFY THIS FILE.
# To complete this assignment you only need to modify
# the files inside the individual /episode-xx/ folders.
# You may, however, take a look inside this file to see
# how the entire program works. Ideally though, you'll
# only need to work with the files inside the individual
# /episode-xx/ folders to fix the replicator each episode.

class Generator

  def self.invoke(command)
    send(command.slice(2..-1).gsub('-', '_'))
  end

  def self.reset_exercises
    destroy_exercises
    create_exercises
  end

  def self.destroy_exercises
    Dir.glob('episode-*').each do |folder|
      puts "Removing #{folder}"
      FileUtils.rm_r folder
    end
  end

  def self.create_exercises
    exercises_folder = './base/exercises/.DO-NOT-LOOK-IN-THIS-FOLDER-UNLESS-YOU-WANT-THE-ANSWERS-TO-THE-EXERCISES'

    Dir.glob("#{exercises_folder}/**").each do |folder|
      episode_number = folder[/\d+$/]
      new_episode_folder = "episode-#{episode_number}"
      puts "Creating #{new_episode_folder}"
      FileUtils.cp_r 'base/episode-skeleton/', new_episode_folder
      FileUtils.cp_r(Dir.glob("#{folder}/*"), new_episode_folder)
    end
  end

end
