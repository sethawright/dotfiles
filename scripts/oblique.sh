#!/usr/bin/env bash
# Draws an Oblique Strategies card.
#
# Each card is for standup, for getting unstuck, or for both.
# A standup card is a theme for the day: everyone who runs --standup on the
# same day gets the same card, so the whole team shares it.
# An unstuck card is random, for the moment you are stuck, as Eno used them.

set -euo pipefail

cards() {
  cat <<'EOF'
both|Authorship|Write the first ten lines yourself. Then give it to the agent.
standup|Authorship|Name everything before the agent does.
standup|Authorship|Which part would you miss if the agent wrote it? Write that part.
standup|Authorship|Make one thing today entirely by hand.
standup|Authorship|Write the commit message before the code.
standup|Authorship|Choose one design decision today and own it fully.
standup|Authorship|Put your taste into one small detail.
standup|Authorship|Write the tests yourself today. Let the agent write the code.
unstuck|Authorship|Delete half of what it gave you.
unstuck|Authorship|Would you sign this?
unstuck|Authorship|Fix the names first.
unstuck|Authorship|What would you do if the agent did not exist?
unstuck|Authorship|Write the hard part. Give the agent the easy part.
unstuck|Authorship|Rewrite the agent's code in your own style.
unstuck|Authorship|Make one decision the agent cannot make.
both|Accident|Give the agent a card and do not tell it why.
standup|Accident|Keep a list of every surprise today.
standup|Accident|Open a random file today and read it.
unstuck|Accident|Keep the mistake. What did the agent think you meant?
unstuck|Accident|Ask for three solutions. Read the strangest one carefully.
unstuck|Accident|Run the same prompt again. The difference is the interesting part.
unstuck|Accident|Do it badly on purpose.
unstuck|Accident|Follow the agent's wrong path for five minutes.
unstuck|Accident|Use the error as an idea for a feature.
unstuck|Accident|Read the warning you usually ignore.
unstuck|Accident|Pick a random line in the file. Start there.
both|Constraint|No agent for the next hour.
standup|Constraint|Ask the agent fewer questions than yesterday.
standup|Constraint|Today, every prompt must be under 50 words.
standup|Constraint|Today, no copying and pasting.
unstuck|Constraint|Write the prompt in one sentence.
unstuck|Constraint|Solve it on paper first.
unstuck|Constraint|Use only what is already in the codebase.
unstuck|Constraint|Give the agent less information.
unstuck|Constraint|Make it work for one user only.
unstuck|Constraint|Use no new dependency.
unstuck|Constraint|Write it in fewer than 20 lines.
unstuck|Constraint|No new files.
unstuck|Constraint|Make it work without a database change.
unstuck|Constraint|Use only plain functions. No classes.
unstuck|Constraint|Give the agent only one file.
unstuck|Constraint|Write it as if it must run for ten years.
unstuck|Constraint|Solve it without an if statement.
standup|Attention|Find one line you would write differently. Rewrite it by hand.
standup|Attention|What did you learn today that the agent did not need to know?
standup|Attention|Read code today that you did not write and did not prompt.
standup|Attention|Notice the moment you start to skim. Stop there.
unstuck|Attention|Read the diff aloud.
unstuck|Attention|Make the error message good.
unstuck|Attention|Read the whole error message slowly.
unstuck|Attention|Look at the data, not the code.
unstuck|Attention|Read the code from the bottom to the top.
unstuck|Attention|Read only the names. What story do they tell?
unstuck|Attention|Count the ideas in the diff. Is one of them too many?
unstuck|Attention|Look at what the agent deleted.
unstuck|Attention|Read only the test names. Do they describe the feature?
unstuck|Attention|Find the line you do not understand. Do not continue until you do.
both|People|Draw it for someone else.
standup|Listening|Listen more than you speak today.
standup|Listening|In each meeting today, listen for what nobody says.
standup|Listening|Ask one person how their work feels. Listen to the whole answer.
unstuck|Listening|Sit quietly for two minutes. Then look again.
unstuck|Listening|Listen to the system. Watch the logs as they happen.
unstuck|Listening|Read the agent's output with no plan to reply.
both|People|Show a person the ugliest part.
standup|People|Pair with a human, not a model.
standup|People|Ask a colleague before you ask the agent.
standup|People|Teach someone one thing today.
standup|People|Share something that is not finished.
standup|People|Review a colleague's work with care, not speed.
standup|People|Work on one problem as a group for an hour.
standup|People|Ask the newest person for their opinion first.
standup|People|Give a specific compliment in a code review.
standup|People|Swap tasks with a colleague for an hour.
standup|People|Have a video lunch with a teammate. Do not talk about work.
standup|People|Call someone instead of writing a message.
standup|People|Ask the team what they made this week.
standup|People|Learn everything you can from one colleague today.
unstuck|People|Explain the problem to someone who is not in the room.
unstuck|People|Ask someone who does not know the code.
unstuck|People|Ask for help now, not in an hour.
unstuck|People|Who has solved this before? Go and ask them.
standup|Communication|Record a short demo of what you made.
standup|Communication|Explain your work to someone outside engineering.
standup|Communication|Write the pull request description like a story.
unstuck|Communication|Write the question you would post in Slack. Often you do not need to post it.
unstuck|Communication|Rewrite the ticket in your own words.
unstuck|Communication|Ask the person who wrote the ticket what they really want.
both|Useful|Who is this for? Say it in one sentence.
standup|Useful|Watch one person use what you built.
standup|Useful|Find the user who will feel this change. Say their name aloud.
standup|Useful|Read the support queue before you read the backlog.
standup|Useful|Ship one small thing that a customer will notice today.
standup|Useful|Ask support what annoys them most.
standup|Useful|Use the product as a customer for 20 minutes.
standup|Useful|Use the product on a slow phone.
standup|Useful|Write the release note first.
standup|Useful|Thank someone for something they built.
unstuck|Useful|What would the user do if this did not exist?
unstuck|Useful|Remove the feature. Does anyone notice?
standup|Making|Build a small tool that only you will use.
standup|Making|Make the thing you wanted when you were new here.
standup|Making|Build it twice: once with the agent, once without. Compare them.
standup|Making|Write a script you will delete tomorrow.
standup|Making|Make a prototype in one hour. Show it at the end of the day.
standup|Making|Write one function slowly, by hand, with full attention.
standup|Making|Start a small side project today. Give it 30 minutes.
standup|Making|Make the internal tool beautiful.
standup|Making|Build the demo before the feature.
standup|Making|Make something for a teammate, not for a ticket.
standup|Making|Finish one thing completely today.
standup|Making|Write code today that you would show in an interview.
unstuck|Making|Build a tiny version outside the codebase first.
unstuck|Making|Make a copy you can throw away. Break it freely.
standup|Puzzle|Pick the hardest bug in the backlog. Keep it for yourself.
standup|Puzzle|Read one clever piece of code until you understand it fully.
unstuck|Puzzle|Predict the output before you run it.
unstuck|Puzzle|Draw the moving parts. Which one moves when it should not?
unstuck|Puzzle|Hold the whole thing in your head. What does not fit?
unstuck|Puzzle|Find the one piece that makes the rest simple when you remove it.
unstuck|Puzzle|Guess the cause of the bug. Then check if you were right.
standup|Learning|Learn one thing today that the agent knows and you do not.
standup|Learning|Ask the agent to teach you, not to do it.
standup|Learning|Read the source of a library you use every day.
standup|Learning|Read the documentation, not the summary.
standup|Learning|Learn the keyboard shortcut you avoid.
standup|Learning|Write down one thing you understand today that you did not understand yesterday.
standup|Learning|Read one old essay about programming.
standup|Learning|Learn how one part of production works that you have never seen.
standup|Learning|Spend 30 minutes in a language you do not use at work.
standup|Learning|Read the git history of the file you change today.
unstuck|Learning|Ask the agent to explain the code. Then explain it back in your own words.
unstuck|Learning|What would you need to know to do this alone?
standup|Medium|Write the design in plain words before any code.
standup|Medium|Write one paragraph about why this system exists.
unstuck|Medium|Describe it as a story. Who does what, and when?
unstuck|Medium|Write the interface you wish existed. Then build it.
unstuck|Medium|Write the README first.
both|Experiment|There is no win and no fail today. Only make.
standup|Experiment|Consider everything today an experiment.
standup|Experiment|Try one idea you are sure will fail.
standup|Experiment|Change one habit for one day only.
unstuck|Experiment|Do not make and judge at the same time. Make now, review later.
unstuck|Experiment|Change one thing. Only one.
unstuck|Experiment|Write down what you expect. Then run it.
standup|Process|Change your mind about one thing today. Say it aloud.
standup|Process|Spend 20 minutes on a problem that is not yours.
standup|Process|Collect ideas today. Do not judge them.
unstuck|Process|Begin anywhere.
standup|Process|Slow down for one task.
standup|Process|Keep a notebook open all day.
unstuck|Process|Go deep. Read one level below where you usually stop.
unstuck|Process|Copy a solution you admire. Then change it.
unstuck|Process|Capture the accident. Take a screenshot before you fix it.
standup|Do|Do the task you avoided yesterday first.
unstuck|Do|Stop thinking about it. Do it.
unstuck|Do|Stop planning. Write the first test.
unstuck|Do|Do the next small thing.
unstuck|Do|Ship the smallest piece now.
unstuck|Do|Stop looking for the right way. Do it one way.
standup|Design|Today, make one future change easier.
unstuck|Design|Make the change easy. Then make the easy change.
unstuck|Design|Tidy first. Then change.
unstuck|Design|What would make the next change easier?
unstuck|Design|Make it work. Then make it right. Then make it fast.
unstuck|Design|Can you do this without a new abstraction?
unstuck|Design|Inline it. Look again.
unstuck|Design|Extract the part that has a name you can say.
unstuck|Design|Make the wrong use impossible.
unstuck|Design|Where does this belong? Not where is it easiest to put it.
unstuck|Design|Write it so that a new hire could change it.
unstuck|Design|What is the boring solution?
unstuck|Reframe|Is the problem the code or the question?
unstuck|Reframe|Describe the result you want, not the steps.
unstuck|Reframe|What is the smallest version that still works?
unstuck|Reframe|Which assumption have you not checked?
unstuck|Reframe|How would you solve this with no computer?
unstuck|Reframe|Make it ten times bigger. Then ten times smaller.
unstuck|Reframe|Ask the agent to argue against your plan.
unstuck|Reframe|Ask the agent what it would ask you.
unstuck|Reframe|What are you afraid to change?
unstuck|Reframe|Have you seen a problem like this before?
unstuck|Reframe|Solve a simpler problem first.
unstuck|Reframe|Solve one special case. Then make it general.
unstuck|Reframe|Make it general. Is the general problem easier?
unstuck|Reframe|Work backward from the result.
unstuck|Reframe|What is unknown? What do you already know?
unstuck|Reframe|Did you use all the information?
unstuck|Reframe|Look at the problem from the user's side.
unstuck|Reframe|Find a comparison outside software.
unstuck|Reframe|Split the problem in two. Solve the easier half.
unstuck|Reframe|Remove one condition. What changes?
unstuck|Reframe|Name the problem in five words.
unstuck|Reframe|What would make this problem disappear?
unstuck|Reframe|Is this the real problem, or a symptom of it?
unstuck|Reframe|What would you do with a week? What would you do with an hour?
unstuck|Transform|Replace one part. What else could do this job?
unstuck|Transform|Combine two parts into one.
unstuck|Transform|Use an idea from another part of the codebase.
unstuck|Transform|Remove a step.
unstuck|Transform|Reverse the order.
unstuck|Transform|Turn it inside out. Let the callee call the caller.
unstuck|Transform|Make the data do the work, not the code.
unstuck|Transform|Make it synchronous. Or make it asynchronous.
unstuck|Transform|Move the logic to the other side of the boundary.
unstuck|Transform|Replace the conditions with a lookup table.
unstuck|Transform|Pull the data instead of pushing it. Or push instead of pull.
unstuck|Debug|Bisect.
unstuck|Debug|Check the easy things first.
unstuck|Debug|Reproduce it before you fix it.
unstuck|Debug|Make the failure smaller.
unstuck|Debug|Add one log line where you are sure it works. Are you right?
unstuck|Debug|Read the code that runs, not the code you think runs.
unstuck|Debug|What changed?
unstuck|Debug|Test the thing you are sure about.
unstuck|Debug|Clear the cache. Restart everything.
unstuck|Debug|Write the test that fails. Then stop.
unstuck|Debug|Compare a working case to a broken case.
unstuck|Debug|Look at the timestamps.
unstuck|Debug|Find who saw this before. Search the history.
unstuck|Debug|Turn off half of it.
standup|Agent|Use one agent at a time today.
standup|Agent|Today, read every line the agent writes.
standup|Agent|Turn off autocomplete for the morning.
standup|Agent|Keep a log of each prompt and what you learned from it.
standup|Agent|Today, let the agent do only the parts you dislike.
standup|Agent|Give the agent the boring work. Keep the interesting work.
unstuck|Agent|Ask the agent what it is unsure about.
unstuck|Agent|Ask the agent for its plan. Change one step.
unstuck|Agent|Make the agent write the test first.
unstuck|Agent|Tell the agent what not to do.
unstuck|Agent|Give the agent one good example.
unstuck|Agent|Ask the agent to walk you through the change, step by step.
unstuck|Agent|Show the agent the error, not your guess.
unstuck|Agent|Let the agent try once with no help. Watch what it does.
unstuck|Agent|Ask the agent which part was hardest.
unstuck|Agent|Ask for the simplest solution. Then ask for the most clever one.
unstuck|Agent|Make the agent run the code and look at the result.
unstuck|Agent|Give the agent a role: a skeptic, a beginner, a user.
unstuck|Agent|Ask a different model.
unstuck|Agent|Cut the task in half. Give the agent only the first half.
unstuck|Agent|Stop correcting. Rewrite the first prompt.
unstuck|Agent|You are prompting in circles. Write it yourself.
unstuck|Agent|Ask the agent to review its own diff as a hostile reviewer.
standup|Pace|Stop at the interesting part.
standup|Pace|Start with the hardest part.
standup|Pace|Take a real lunch break, away from the screen.
standup|Pace|Leave early when the work is good.
standup|Pace|Do one thing at a time today.
standup|Pace|No notifications until lunch.
standup|Pace|Make the morning slow and the afternoon fast.
standup|Pace|Plan less. Look more.
unstuck|Pace|Let the agent wait.
unstuck|Pace|Is it finished?
unstuck|Pace|Leave it. Come back after lunch.
unstuck|Pace|Sleep on it.
unstuck|Pace|Get a glass of water. Then decide.
unstuck|Pace|Go faster. Make a rough version now.
both|Place|Walk while you think. Sit down only to decide.
standup|Place|Work outside.
standup|Place|Work away from your desk for one hour. Take only a notebook.
standup|Place|Work standing at the kitchen counter.
standup|Place|Work next to a window.
standup|Place|Work in a Slack huddle with the team. Talk only when you need to.
standup|Place|Work from a different room this morning. Take only the laptop.
unstuck|Place|Move to a different chair.
unstuck|Place|Leave the room.
both|Device|Use a small screen. Close every window except one.
standup|Device|Work on your phone only until lunch.
standup|Device|Unplug the second monitor.
standup|Device|Work with no internet for one hour. What can you still do?
standup|Device|Try a tool you have never used.
standup|Device|Use only the terminal today.
standup|Device|Use an editor you do not usually use.
standup|Device|Leave your phone in another room.
unstuck|Device|Write the prompt by voice.
unstuck|Device|Turn off syntax highlighting.
unstuck|Device|Read the code on paper or on your phone, not in the editor.
standup|Paper and hands|Draw the architecture before you open the editor.
standup|Paper and hands|Keep a paper list of what you finish today.
unstuck|Paper and hands|Write the prompt by hand. Then type it.
unstuck|Paper and hands|Explain the change on paper. Give the agent a photo of it.
unstuck|Paper and hands|Write each step on a small piece of paper. Move them around.
unstuck|Paper and hands|Draw the data as boxes and arrows.
unstuck|Paper and hands|Write the query by hand first.
standup|Body|Take one call as a walk, with no video.
standup|Body|Eat lunch outside.
standup|Body|Move every hour today.
unstuck|Body|Stand up for this task.
unstuck|Body|Take a walk, then read the agent's result.
unstuck|Body|Lie down and read the code.
unstuck|Body|Do the dishes while the agent works. Think about something else.
unstuck|Body|Stretch for two minutes.
unstuck|Body|Breathe slowly ten times.
standup|Senses|Work in silence.
standup|Senses|Play music that you do not usually hear when you work.
standup|Senses|Change the editor theme to something you do not like.
standup|Senses|Work with only natural light.
standup|Senses|Listen to one album from start to end while you work.
unstuck|Senses|Make the font very large.
unstuck|Senses|Close your eyes. Describe the system from memory.
standup|Time|Start the agent at the end of the day. Read the result in the morning.
standup|Time|Work in 25-minute blocks today.
standup|Time|Spend the first hour of the day only thinking.
standup|Time|Do the creative work before you read messages.
standup|Time|End the day with 30 minutes of free exploration.
standup|Time|Spend one hour this afternoon on something you love.
unstuck|Time|Give yourself 15 minutes. Stop when the time ends.
unstuck|Time|Set a timer for five minutes. Write anything.
standup|Play|Make something useless today.
standup|Play|Follow your curiosity for one hour.
standup|Play|Notice the moment today when you feel like a maker.
standup|Play|Give your branch a ridiculous name.
standup|Play|Hide a small joke in a test name.
standup|Play|Make a tiny game.
standup|Play|Build something in a toy language.
standup|Play|Make the loading state delightful.
standup|Play|Draw the system as a map of a city.
standup|Play|Solve one small puzzle with a teammate in the fewest characters.
standup|Play|Make a sound play when the tests pass.
standup|Play|Do a 20-minute coding exercise just for practice.
standup|Play|Make a terrible version together. Laugh about it.
standup|Mario Kart|Race once at the end of standup. Last place reads the card tomorrow.
standup|Mario Kart|End the day with one race. The winner names a branch tomorrow.
standup|Mario Kart|Rainbow Road day: take the hardest task on the board.
standup|Mario Kart|Which character is the code you work on today? Why?
both|Mario Kart|Someone is in last place. Give them help, not a blue shell.
unstuck|Mario Kart|Mushroom, star, or blue shell? A small push, no fear, or attack the biggest problem.
unstuck|Mario Kart|Banana peel: find the thing you will slip on later. Remove it now.
unstuck|Mario Kart|Shortcut or track? Decide on purpose.
unstuck|Mario Kart|Stuck? Race once. Then look again.
standup|Care|Do the boring task with care.
standup|Care|Fix one small thing that nobody asked for.
standup|Care|Read one message from a real user.
standup|Care|Leave one file better than you found it.
standup|Care|Write one test you are proud of.
standup|Care|Improve one log message.
standup|Care|Delete one thing that nobody uses.
standup|Care|Update the documentation you trusted last week.
standup|Care|Make one page work better on a phone.
standup|Care|Improve one empty state.
standup|Care|Make the slowest thing a little faster.
standup|Care|Check the accessibility of one screen.
standup|Care|Answer an old question in a channel.
unstuck|Restart|Start a new session. Bring only what you know now.
unstuck|Restart|Throw away the branch. Start again.
unstuck|Restart|Go back to the last time it worked.
unstuck|Restart|Change one word in the prompt.
unstuck|Restart|Revert everything. Keep only the test.
unstuck|Restart|Go back to the ticket. Read it again from the start.
unstuck|Restart|Start from the user's screen, not the database.
unstuck|Restart|Undo the last three changes.
EOF
}

usage() {
  cat <<'EOF'
Usage: oblique.sh [option]

  (none)       A random card for when you are stuck.
  --unstuck    The same as no option.
  --standup    Today's standup card. It is the same for everyone all day.
  --standup --random
               A random standup card. It is different each time.
  --list       Show the full deck, in its two groups.
  --help       Show how to use the cards.
EOF
}

help() {
  usage
  cat <<'EOF'

WHAT THIS IS

  Oblique Strategies is a deck of cards that Brian Eno and Peter Schmidt
  made in 1975. Each card has one short instruction or question. The cards
  do not give you the answer. They change how you look at the problem.

  This deck is our own. It is written for a team that works with coding
  agents. Agents can take away the parts of the work that felt like making
  something. The cards try to give some of those parts back: authorship,
  surprise, craft, attention, and time with other people.

TWO WAYS TO USE IT

  Standup (--standup)
    One card is a theme for the day. Read it aloud at standup. Keep it in
    mind during the day. Nobody has to do it.

  Unstuck (no option)
    This is how Eno used the deck. Draw a card when the work stops: when
    you are under pressure, when you go in circles, when the work is
    correct but has no life, or when there are too many choices. In flow,
    do not draw a card. It can break the flow.

    Good moments to draw a card:
      - The agent failed three times, and you will send the same prompt again.
      - You feel the pressure to "just make it pass."
      - You read a large diff and feel nothing.
      - You cannot choose between two designs.

HOW TO TAKE IT SERIOUSLY

  1. Trust the card, even when you cannot see how it applies. Eno's
     instruction was the same. If you cannot follow the card, look for a
     way to follow it. That effort is the useful part.
  2. Give it a real try. Spend at least a few minutes with the card before
     you decide that it does not work.
  3. Do not draw again because you do not like the card. A card you
     dislike is often the one you need.
  4. Notice what happens. Write one line about it, if you can.

HOW NOT TO TAKE IT TOO SERIOUSLY

  - A card is an invitation, never an order. When someone gives a card to
    another person as an instruction, it stops working. Eno found this in
    the studio: some musicians disliked cards that were given to them.
  - Do not measure it. Do not count cards per sprint. Metrics turn play
    into work.
  - Keep it short at standup. Read the card, maybe say one thing, continue.

THE TEAM RITUAL

  - At standup: one person runs oblique.sh --standup and reads the card.
  - In the retro, ask two questions:
      "Did anyone use a card this week? What happened?"
      "When this week did you feel like a maker?"
    Write the answers down. After some weeks, you will see what brings the
    joy back for this team.
  - If the team does not like today's card, run oblique.sh --standup --random.

THE SAME CARD FOR EVERYONE

  oblique.sh --standup gives everyone the same card on the same day, on
  macOS and on Linux, if:
    - everyone has the same version of this file,
    - everyone has the same date (the script uses the local date), and
    - nobody adds --random.

  Keep one shared copy of this script, so the deck stays the same.

CHANGE THE DECK

  The deck belongs to the team. Eno and Schmidt did not invent their cards.
  They wrote down what already helped them. Do the same: ask each person to
  write a few cards from their own experience, and add them.

  Each card is one line in the cards() function, in this format:

    standup|Play|Make something useless today.
    unstuck|Reframe|Is the problem the code or the question?
    both|People|Show a person the ugliest part.

  The first word says where the card goes: standup, unstuck, or both.
  The second part is the category. A new category shows up automatically.
  Remove the cards that nobody likes. Change the first word if a card is
  in the wrong group.

  When you add or remove a card, most days keep their standup card. Only
  the days that the new or removed card wins are different. To change the
  words of a card, or its category, is safe in the same way. Share each
  change with the whole team, so everyone has the same deck.

WHERE THE IDEAS COME FROM

  Brian Eno and Peter Schmidt (Oblique Strategies), Fred Brooks (The Joys
  of the Craft), Corita Kent (art department rules), Bruce Mau (Incomplete
  Manifesto for Growth), Sol LeWitt (letter to Eva Hesse), Pauline Oliveros
  (Sonic Meditations), George Polya (How to Solve It), SCAMPER (Osborn and
  Eberle), Kent Beck, and writing on AI and the joy of programming.
  The card text is our own. The original Eno cards are not in this deck.
EOF
}

cards_for() {
  cards | awk -F'|' -v use="$1" '$1 == use || $1 == "both" { print $2 "|" $3 }'
}

list_cards_for() {
  cards_for "$1" | awk -F'|' '{ printf "  %-16s %s\n", $1, $2 }'
}

# Each card gets a score from today's date and its own text, and the highest
# score wins. So when someone adds or removes a card, only the days that card
# wins are different. Every other day keeps its card.
# The numbers stay small enough that every awk gets the same result.
todays_card() {
  cards_for standup | LC_ALL=C awk -F'|' -v day="$(date +%Y-%m-%d)" '
    function score(text, base,    total, i) {
      total = 0
      for (i = 1; i <= length(text); i++) {
        total = (total * base + code[substr(text, i, 1)]) % prime
      }
      return total
    }
    BEGIN {
      prime = 67108859
      for (i = 1; i < 128; i++) code[sprintf("%c", i)] = i
      base = 2 + score(day, 131) % (prime - 3)
    }
    {
      current = score($2, base)
      if (NR == 1 || current > best) { best = current; card = $0 }
    }
    END { print card }
  '
}

draw() {
  local use=$1 order=${2:-random} card
  if [[ $order == today ]]; then
    card=$(todays_card)
  else
    local pool=()
    while IFS= read -r line; do
      pool+=("$line")
    done < <(cards_for "$use")
    card=${pool[$((RANDOM % ${#pool[@]}))]}
  fi

  local category
  category=$(printf '%s' "${card%%|*}" | tr '[:lower:]' '[:upper:]')
  printf '\n  %s\n\n  %s\n\n' "$category" "${card#*|}"
}

case "${1:-}" in
  ""|--unstuck)
    draw unstuck
    ;;
  --standup)
    case "${2:-}" in
      "") draw standup today ;;
      --random) draw standup random ;;
      *) usage >&2; exit 1 ;;
    esac
    ;;
  --list)
    printf '\nSTANDUP: a theme for the day\n\n'
    list_cards_for standup
    printf '\nUNSTUCK: draw one when the work stops\n\n'
    list_cards_for unstuck
    echo
    ;;
  -h|--help)
    if [[ -t 1 ]]; then
      help | ${PAGER:-less -FX}
    else
      help
    fi
    ;;
  *)
    usage >&2
    exit 1
    ;;
esac
