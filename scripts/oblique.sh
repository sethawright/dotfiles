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
unstuck|Accident|Let the agent finish the wrong idea. What did you learn?
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
standup|People|Have lunch with someone from another team.
standup|People|Call someone instead of writing a message.
standup|People|Ask the team what they made this week.
standup|People|Learn everything you can from the person next to you.
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
standup|Making|Start a side project at lunch.
standup|Making|Make the internal tool beautiful.
standup|Making|Build the demo before the feature.
standup|Making|Make something for a teammate, not for a ticket.
standup|Making|Finish one thing completely today.
standup|Making|Write code today that you would show in an interview.
unstuck|Making|Build a tiny version outside the codebase first.
unstuck|Making|Make a copy you can throw away. Break it freely.
standup|Puzzle|Pick the hardest bug in the backlog. Keep it for yourself.
standup|Puzzle|Solve one problem today without help from the agent.
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
standup|Learning|Read a chapter of an old programming book.
standup|Learning|Learn how one part of production works that you have never seen.
standup|Learning|Try a language you do not use at work.
standup|Learning|Read the git history of the file you change today.
unstuck|Learning|Ask the agent to explain the code. Then explain it back in your own words.
unstuck|Learning|What would you need to know to do this alone?
standup|Medium|Write the design in plain words before any code.
standup|Medium|Write one paragraph about why this system exists.
unstuck|Medium|Describe it as a story. Who does what, and when?
unstuck|Medium|Write the interface you wish existed. Then build it.
unstuck|Medium|Write the README first.
unstuck|Medium|Model it with index cards on a table.
both|Experiment|There is no win and no fail today. Only make.
standup|Experiment|Consider everything today an experiment.
standup|Experiment|Try one idea you are sure will fail.
standup|Experiment|Change one habit for one day only.
standup|Experiment|Be happy whenever you can.
standup|Experiment|Find a place you trust. Try trusting it for a while.
unstuck|Experiment|Do not make and judge at the same time. Make now, review later.
unstuck|Experiment|Change one thing. Only one.
unstuck|Experiment|Write down what you expect. Then run it.
standup|Process|Let the process lead today, not the outcome.
standup|Process|Allow today to change your mind.
standup|Process|Work on the wrong problem for an hour.
standup|Process|Collect ideas today. Do not judge them.
standup|Process|Begin anywhere.
standup|Process|Slow down for one task.
standup|Process|Keep a notebook open all day.
unstuck|Process|Go deep. Read one level below where you usually stop.
unstuck|Process|Make a mess first. Clean it later.
unstuck|Process|Copy a solution you admire. Then change it.
unstuck|Process|Capture the accident. Take a screenshot before you fix it.
standup|Do|Do the task you avoided yesterday first.
unstuck|Do|Stop thinking about it. Do it.
unstuck|Do|Stop planning. Write the first test.
unstuck|Do|Do the next small thing.
unstuck|Do|Ship the smallest piece now.
unstuck|Do|Stop looking for the right way. Do it one way.
standup|Design|Today, protect the future, not only the feature.
standup|Design|Delete code today.
unstuck|Design|Make the change easy. Then make the easy change.
unstuck|Design|Tidy first. Then change.
unstuck|Design|What would make the next change easier?
unstuck|Design|Which option does this close? Keep it open.
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
unstuck|Reframe|Draw it.
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
unstuck|Transform|Make one part much more important than the rest.
unstuck|Transform|Use it for something else.
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
unstuck|Debug|Explain it line by line to a rubber duck.
unstuck|Debug|Write the test that fails. Then stop.
unstuck|Debug|Compare a working case to a broken case.
unstuck|Debug|Look at the timestamps.
unstuck|Debug|Is it the data or the code?
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
unstuck|Agent|Ask the agent to explain your own code to you.
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
unstuck|Pace|Wait ten minutes before you send the next prompt.
unstuck|Pace|Go faster. Make a rough version now.
both|Place|Walk while you think. Sit down only to decide.
standup|Place|Work outside.
standup|Place|Work in a room you have never worked in.
standup|Place|Work at a coffee shop. Leave your laptop at home.
standup|Place|Work from the place where your users are.
standup|Place|Go to a colleague's desk. Work from there for an hour.
standup|Place|Work standing at the kitchen counter.
standup|Place|Work next to a window.
standup|Place|Work from a library.
standup|Place|Work in the same room as the team.
standup|Place|Work in a park for the first hour.
standup|Place|Work on a train or a bus.
unstuck|Place|Move to a different chair.
unstuck|Place|Leave the room.
both|Device|Use a small screen. Close every window except one.
standup|Device|Work on your phone only.
standup|Device|Use only a tablet and a pen.
standup|Device|Unplug the second monitor.
standup|Device|Work with no internet for one hour. What can you still do?
standup|Device|Try a tool you have never used.
standup|Device|Use only the terminal today.
standup|Device|Use an editor you do not usually use.
standup|Device|Use graph paper and a pencil for design.
standup|Device|Work on an old laptop.
standup|Device|Leave your phone in another room.
unstuck|Device|Write the prompt by voice.
unstuck|Device|Turn off syntax highlighting.
unstuck|Device|Turn the monitor to portrait.
unstuck|Device|Read the code on paper or on your phone, not in the editor.
standup|Paper and hands|Draw the architecture before you open the editor.
standup|Paper and hands|Keep a paper list of what you finish today.
unstuck|Paper and hands|Write the prompt by hand. Then type it.
unstuck|Paper and hands|Print the diff. Review it with a pen.
unstuck|Paper and hands|Explain the change on a whiteboard. Give the agent a photo of it.
unstuck|Paper and hands|Write the steps on sticky notes. Move them around.
unstuck|Paper and hands|Draw the data as boxes and arrows.
unstuck|Paper and hands|Write the query by hand first.
standup|Body|Have one meeting as a walk.
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
unstuck|Senses|Read the code in a different font.
unstuck|Senses|Close your eyes. Describe the system from memory.
standup|Time|Work at a time of day when you do not usually work.
standup|Time|Start the agent at the end of the day. Read the result in the morning.
standup|Time|Work in 25-minute blocks today.
standup|Time|Spend the first hour of the day only thinking.
standup|Time|Do the creative work before you read messages.
standup|Time|End the day with 30 minutes of free exploration.
standup|Time|Spend this afternoon on something you love.
unstuck|Time|Give yourself 15 minutes. Stop when the time ends.
unstuck|Time|Set a timer for five minutes. Write anything.
standup|Play|Make something useless today.
standup|Play|Follow your curiosity for one hour.
standup|Play|Notice the moment today when you feel like a maker.
standup|Play|End the day with something to show.
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
  --standup    Today's standup card. It is the same for everyone on the same day.
  --standup --random
               A random standup card. It is different each time.
  --list       Show the full deck, in its two groups.
  --help       Show this help.
EOF
}

cards_for() {
  cards | awk -F'|' -v use="$1" '$1 == use || $1 == "both" { print $2 "|" $3 }'
}

list_cards_for() {
  cards_for "$1" | awk -F'|' '{ printf "  %-16s %s\n", $1, $2 }'
}

draw() {
  local use=$1 order=${2:-random} index
  local pool=()
  while IFS= read -r line; do
    pool+=("$line")
  done < <(cards_for "$use")

  if [[ $order == today ]]; then
    local seed
    seed=$(date +%Y-%m-%d | cksum | cut -d' ' -f1)
    index=$((seed % ${#pool[@]}))
  else
    index=$((RANDOM % ${#pool[@]}))
  fi

  local card=${pool[$index]}
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
    usage
    ;;
  *)
    usage >&2
    exit 1
    ;;
esac
