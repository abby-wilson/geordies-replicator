# Ruby Debugging:
# Geordi's Replicator Woes

## Intro

Now that you're familiar with programming fundamentals, we'd like to introduce you to what you'll *really* be spending most of your time doing: **debugging**.


> If debugging is the process of removing software bugs, then programming must be the process of putting them in.
*- Edsger W. Dijkstra*

Today you are Geordi La Forge, chief engineer of the Enterprise from Star Trek. Just like Geordi would climb through the narrow corridors of the Jefferies tubes to troubleshoot the Enterprise's issues, you'll be using debugging techniques to get in between the nooks and crannies of your programs to figure out what's really going on.

![Geordi and Data Crawling Through a Jefferies Tube](https://raw.githubusercontent.com/bitmakerlabs/geordis-replicator/master/base/art/geordi-data-crawling-through-jefferies-tubes.jpg)

*Geordi and Data Crawling Through a Jefferies Tube*

## Prerequisite Knowledge

You should be comfortable with:

- [ruby fundamentals](ruby-fundamentals.md)
- working on your command line
- working with your editor


## Goal of this Assignment

By the end of this exercise, you should have a good understanding of how to debug programs by intercepting them as they run to see what's going on.


## Getting Started

You'll need your editor for coding, a terminal for running and testing code, and a browser for looking up documentation.

In addition, you'll need to download this repo and ensure `pry` is installed.

```bash
# Clone Repo
git clone git@github.com:bitmakerlabs/geordis-replicator.git

# Go into project folder
cd geordis-replicator

# Install pry
gem install pry
```

## Instructions

### Episode 1: Caffeine Kickoff

Let's run the app once. Use the replicator to make Geordi a coffee and get the day started:

```bash
$ ruby geordis-replicator.rb 1
```

Notice the `1` in the command above. It's an argument you're passing into the `geordis-replicator` ruby program. That number `1` represents the episode number you'd like to play.

The program should run properly. In this case the replicator should make a coffee for Geordi, and then prompt you to move on to the next episode. Before you start the next episode, take a look at the files in the `/episode-01/` subfolder. In here you'll find the *Enterprise* class, *Replicator* class, and all the other classes to make the replicator work. Episode 1 doesn't have any bugs, so you don't need to fix the program.

Now take a look at the files in the `/base/` folder. This is the *"framework"* of this assignment. You should not change any of these files to fix the bugs in each assignment, or else future episodes may not work properly. You'll may also notice a very long named folder beginning with `.DO-NOT-LOOK-blah-blah...`. This folder is used to generate each exercise, and you may spoil the exercises for yourself if you look at the files in this folder.

### Episode 2: Midnight Visitor

Let's first run the second episode and see what happens:

```ruby
$ ruby geordis-replicator.rb 2
```

As you can see, one of our characters is not happy when the replicator doesn't function properly. 

Take a look at `reactor.rb` and notice the following line:

```ruby
# turn_on
```

The code to `turn on` the reactor has been commented out. Uncomment that and run the program again. Our character should be happy with their drink now!

> Sometimes it pays to stay in bed on Monday, rather than spending the rest of the week debugging Monday's code.
*- Christopher Thompson*

### Episode 3: Chocolate Solves Everything

Let's first run this episode and see what happens:

```ruby
$ ruby geordis-replicator.rb 3
```

To troubleshoot it, we'll need to follow the flow of the program. Let's start with `geordis_replicator.rb`, the program you run from the command line:

```ruby
require_relative 'base/app'

App.new
```

This simply loads `base/app.rb` into memory and then creates a new instance of `App`.

Let's see what happens when a new instance of App is created:



```ruby
  # base/app.rb

  def initialize

    command = ARGV.first
    Display.help_and_exit unless command

    if command.slice(0, 2) == '--'
      Generator.invoke(command)
    else
      episode_number = pad_with_zero(command)
      play(episode_number)
    end

  end

```

This `initialize` method:

1. Ensures an episode # was passed in as an argument.
- Invokes the `play` method.

Along with displaying the episode text, the `play` method:

1. Creates an instance of the `Episode` class.
1. Loads the ruby exercise files (i.e. the files in the `episode-03/` folder).
- Creates a new instance of Enterprise.
- Tries to replicate a drink.

Let's move on to the `episode-03/enterprise.rb` file. The `episode-03/` folder is where your debugging should begin, and you can change any of the `.rb` in this folder to make the replicator work properly. *(Note that you shouldn't change the **episode.json** file in this folder)*.

Inside `episode-3/enterprise.rb`, the *Enterprise* is constructed:

```ruby
  def initialize
    @reactor     =     Reactor.new(self)
    @transporter = Transporter.new(self)
    @cupboard    =    Cupboard.new
    @pantry      =      Pantry.new
    @replicator  =  Replicator.new(self)
  end
```

You can then continue to follow the flow by looking at the `initialize` methods of each of the *Enterprise* components.

After the *Enterprise* is created, execution returns to`App#play`, where you'll find the line:

```ruby
@enterprise.replicator.replicate(@episode.recipe)
```

This is where the magic happens! (or is supposed to happen, if only our replicator was working properly).

Take a look at `Replicator#replicate`:

```ruby
  def replicate(recipe)
    @recipe = recipe
    retrieve_glass
    transport_ingredients_to_glass
    mix
    adjust_temperature
    transport_glass_to_replicator_plate
  end
```

1. A recipe is passed in as a local variable (`recipe`), and then assigned to an instance variable (`@recipe`).
- The replicator transports a glass from the cupboard to the replicator's tummy.
- The replicator transports ingredients into the glass.
- The replicator mixes the contents of the glass.
- The replicator transports the glass into the reactor core, adjusts the temperature, and then transports it back to the replicator's tummy.
- The replicator then transports the glass from inside its tummy on the replicator's serving plate so the character can obtain it.

Let's run the program and see what happens:

```bash
$ ruby geordis-replicator 3
```

Hmmm.. it seems like there's a problem with the temperature.

Add `require 'pry'` to the top of `episode-3/replicator.rb`, and inside of `Replicator#adjust_temperature`, add `binding.pry`:

```ruby
  def adjust_temperature
    return unless glass_in_tummy

    binding.pry # <--- add binding.pry here

    glass_in_reactor_core = @enterprise.transporter.energize(obj: glass_in_tummy, from: @tummy, to: @enterprise.reactor.core)
```

Run the program again and it should bring you to the pry prompt:

```ruby
[1] pry(#<Replicator>)>
```

Type `glass_in_tummy` at the prompt to see what the glass currently looks like.

```ruby
[1] pry(#<Replicator>)> glass_in_tummy
=> #<Glass:0x007f841c35e8f8
 @errors=[],
 @inside=
  #<Location:0x007f841c35e8d0
   @contents=
    [#<Ingredient:0x007f841c33c168 @name="chocolate">,
     #<Ingredient:0x007f841c33c258 @name="sugar">,
     #<Ingredient:0x007f841c33c0c8 @name="milk">]>,
 @temperature=37>
```

Notice the temperature is 37 Celsius.

Let's move our `binding.pry` statement to after the temperature adjustment has been finished:

```ruby
  def adjust_temperature

<--- snip --->

    @enterprise.transporter.energize(obj: glass_in_reactor_core, from: @enterprise.reactor.core, to: @tummy)

    binding.pry # <--- move binding.pry to here

  end
```

Run the program again and check the temperature:

```ruby
[1] pry(#<Replicator>)> glass_in_tummy
=> #<Glass:0x007fa7bea35b70
 @errors=[],
 @inside=
  #<Location:0x007fa7bea35b48
   @contents=
    [#<Ingredient:0x007fa7bea0fc40 @name="sugar">,
     #<Ingredient:0x007fa7bea0fbc8 @name="chocolate">,
     #<Ingredient:0x007fa7bea0fb50 @name="milk">]>,
 @temperature=1>
```

Notice the temperature went down to 1 degree! No wonder our character is upset. Somewhere in this method, or a method this method calls, is causing our problem.

Let's move our breakpoint to inside the loop:

```ruby
    while glass_in_reactor_core.temperature != desired_temperature &&
          number_of_adjustments < maximum_adjustments_allowed

      binding.pry # <--- move binding.pry to here

      if glass_in_reactor_core.temperature > desired_temperature
        @enterprise.reactor.cool_items_in_core
      elsif glass_in_reactor_core.temperature < desired_temperature
        @enterprise.reactor.heat_items_in_core
      end

      number_of_adjustments += 1

    end
```

Run the program, and check what temperature of our glass is. Note that the glass has been moved to the *Reactor Core* and is now being tracked in the local variable `glass_in_reactor_core`:

```ruby
[1] pry(#<Replicator>)> glass_in_reactor_core
=> #<Glass:0x007fb08e23d660
 @errors=[],
 @inside=
  #<Location:0x007fb08e23d610
   @contents=
    [#<Ingredient:0x007fb08e216a38 @name="sugar">,
     #<Ingredient:0x007fb08e2169c0 @name="chocolate">,
     #<Ingredient:0x007fb08e216948 @name="milk">]>,
 @temperature=37>
```

The temperature is currently 37 degrees -- the starting temperature of all our drinks. Let's let the loop cycle once by pressing `CONTROL-D` to exit pry. It will run the code below `binding.pry`, and then cycle back to the breakpoint. Type `glass_in_reactor_core` again to see the temperature:

```ruby
[1] pry(#<Replicator>)> glass_in_reactor_core
=> #<Glass:0x007fb08e23d660
 @errors=[],
 @inside=
  #<Location:0x007fb08e23d610
   @contents=
    [#<Ingredient:0x007fb08e216a38 @name="sugar">,
     #<Ingredient:0x007fb08e2169c0 @name="chocolate">,
     #<Ingredient:0x007fb08e216948 @name="milk">]>,
 @temperature=1>
```

Ah ha! Somewhere in the loop the temperature has gone down to one degree. Let's run the loop one more type by pressing `CONTROL-D`. It should bring us back to the pry prompt again. Let's see if our temperature changed:

```ruby
[1] pry(#<Replicator>)> glass_in_reactor_core
=> #<Glass:0x007fb08e23d660
 @errors=[],
 @inside=
  #<Location:0x007fb08e23d610
   @contents=
    [#<Ingredient:0x007fb08e216a38 @name="sugar">,
     #<Ingredient:0x007fb08e2169c0 @name="chocolate">,
     #<Ingredient:0x007fb08e216948 @name="milk">]>,
 @temperature=1>
```

Nope.. still one degree. Unfortunately our loop is going to happen 48 more times. Fortunately, we can break out of our program it with `!!!`:

```ruby
[1] pry(#<Replicator>)> !!!
```

You should be back at your terminal prompt after you typed `!!!`.

I have a feeling the issue is in the Reactor. Open up `episode-3/reactor.rb`. Near the bottom are our methods for heating and cooling:

```ruby
  def heat_items_in_core
    @core.contents.each do |item|
      item.temperature = 1 if draw_power
    end
  end

  def cool_items_in_core
    @core.contents.each do |item|
      item.temperature -= 1 if draw_power(2)
    end
  end
```

`heat_items_in_core` sets the temperature to 1 degree, but the cooling method subtracts one degree from the current temperature. I think our heating method should just increment the temperature by one degree instead of setting it to one degree. Let's fix that now:

```ruby
  def heat_items_in_core
    @core.contents.each do |item|
      item.temperature += 1 if draw_power. # FIXED!
    end
  end
```

Run our program...

...and our character is happy! Good job Geordi!

> Debuggers don't remove bugs. They only show them in slow motion.
*- Unknown*


### Remaining Episodes

Every time you run the program, each episode will have one of the following outcomes:

- character's drink creation is successful
- drink does not appear
- drink is the wrong temperature
- drink has the wrong ingredients
- syntax error

You can look at the `episode.json` file in each episode folder to see what temperature each beverage should be as well as what ingredients it should contain (note: you shouldn't modify this file).

Feel free to change any `.rb` files inside of each `/episode-XX/` folder in order to fix the problem.  Some exercises have multiple bugs. How you fix issues is up to you: for example, you could adjust a program's logic and / or increase the amount times components are stocked. As long as our characters get the drink they want with the right ingredients and at the right temperature, then any fix is valid. 

And now, fix the issues the remaining episodes. Engage!


> Debugging is anticipated with distaste, performed with reluctance, and bragged about forever.
*- Dan Kaminsky*

## Submitting

Remember to submit your code when you're finished.

> It's not a bug – it's an undocumented feature.
> *- Unknown*

## Stretch Goals

### Stretch Goal #1: Create your own episodes

1. Copy the folder `episode-01` to `episode-16`.
- Modify the episode's parameters in `episode-16/episode.json` to reflect a new character, beverage and add some funny lines for this character.
- Introduce some bugs in various components of the Enterprise (i.e. `.rb` in `episode-16/`)
- Test to ensure the program runs (but branches to the character not being happy)
- Send over the `episode-16` folder to your classmates. Have them place your folder in their folder, and then try to solve your exercise.

### Stretch Goal #2: Expand the Replicator's Capabilities

Currently our replicator only handles beverages. Expand the replicator's capabilities to handle solid foods, and then treat yourself to Worf's favourite dish: **Rokeg blood pie**. You deserve it!

![Rokeg Blood Pie... mmmmm...yum.](https://raw.githubusercontent.com/bitmakerlabs/geordis-replicator/master/base/art/rokeg-blood-pie.jpg)

*Rokeg Blood Pie... mmmmm...yum.*

> Without requirements or design, programming is the art of adding bugs to an empty text file.
*- Louis Srygley*
