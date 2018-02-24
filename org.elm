module Org exposing (source)

source = """#+TODO: TOWORK(w) TOASK(a) TOCHECK(c) TOSHARE(s) | REVIEWING(r) DONE(d) 
* Jobs Invite Emails
** Definitions
*** Add new company to jobs market -> superadmin update happens setting the jobsMarket flag
*** 
** Orthogonal
*** Ask TJ how mongoose gets hooked up through services. BlackMagicFuckery
* REVIEWING Remove sandbox from intro/unmasking flow
  CLOSED: [2018-02-22 Thu 17:35]
** Clarification
*** Is the new intro/unmasking flow "Would you hire/work with them?" or Unmask at the end of an interview?
*** Possibly update faq to reflect how de-anonymize works?
** There's a [[file:client/app/interview/controllers/interview.live.js::if%20($scope.interview.introduced%20||%20_.get($scope.interview,%20'_org.accountSettings.disableIntro'))%20{][flag]] checked when considering intro -> Added Sandbox
** Orthogonal 
   Is there a stripped down object that at least has the UI decisions for an org if we'd rather be lean?
Is [[file:server/api/employer/employer.model.js::EmployerModel.getUserFacingEmployerData%20=%20async%20function(employerIds)%20{][this]] that?
* Eventreg
** DONE Vela's UI Changes
   CLOSED: [2018-02-17 Sat 16:41]
*** Just need the picture
** DONE Heroku financeing
   CLOSED: [2018-02-17 Sat 16:41]
*** [[https://devcenter.heroku.com/articles/legacy-dynos%0A][We don't have legacy dynos]]
*** [[https://devcenter.heroku.com/articles/usage-and-billing#billing-cycle-current-usage%20][Db is monthly, but dynos prorated to the second]] 
** TOWORK Make Testing Environment
** TOWORK Code reviews
** TOWORK Parameter Testing
** TOWORK Integration Testing
** TOWORK Profile DB?
* Org File parser in Elm
** Rationale
*** Elm has nice parsers
*** Elm has nice UI building
*** Elm has an emacs crowd, probably
** Steps
*** Parse subset of emacs org syntax in elm
*** Generate a nice one-way ui off of that AST
*** Make a two way binding between an org-file-string and a ui
**** Mode 1 only edits things like visibility, toggles, todos, etc
**** Mode 2 can edit eh-ver-ee-thingggg 
*** Make a port so js people can use it and appreciate elm
*** Dig into client side file management
**** Can I read the org files given a .git blob?
***** And maybe write a commit with modifications?
** Take this
https://github.com/elm-tools/parser
http://karl-voit.at/2017/09/23/orgmode-as-markup-only/
https://orgmode.org/worg/
https://terezka.github.io/line-charts/
* Bookshelves
[[https://www.antoniomallia.it/lets-implement-a-gaussian-naive-bayes-classifier-in-python.html][Gaussian naive bayes classifier in python]]
* @And How
** @Distractions
*** Programmer health. Why does my watch hurt. How can I not need caroptonulgloves
*** Can I get a magit shortcut? Global keymap that like , is for main mode?
*** What are typical access rates for our DB?
*** Prettier option to put chained methods on one line if reasonable?
*** names for TODO
*** Is muzak more tollerable if computer generate? Existentially?
*** Make times noticeable?
*** Debugger prevents server restart from file change
*** Speed up dotfiles.git with ignores
** @Cadence
 - Define timer validity better
 - Phillz geek out with Ana
** @DB
   mongodump --host  candidate.68.mongolayer.com --port 10161 --db app29596024 -u drew 

   mongo
     db.dropDatabase()
     db.copyDatabase('app29596024', 'interviewingio-dev')
** @Debugging
   npx grunt serve --inspect
   (in chrome) about:inspect
** @Pull Request Precheck
*** Do your new variable names make sense given their context?
**** e.g. You moved all the orgSupportsAvailability logic to the Employer.Model without adjusting
*** Can you remove a db call in some cases? 
**** e.g. You could skip ModelEmployers.find for empty lists in user.controller.me
*** Don't use var on the server.
**** "In these cases, they are const (otherwise let)." -tj
*** camelCase
*** Are you using the libraries well?
There was a lodash function to _.clamp values
There was a between_moments function while you did two seperate comparisons.
** @Dissections
*** Recording, streaming of interview sessions.
* DONE Multiple account filter                                      :ARCHIVE:
  CLOSED: [2018-02-14 Wed 15:03]
* DONE Confirm readme :ARCHIVE:
* DONE Set Availability Restrictions                                :ARCHIVE:
** DONE Do we consolidate the terminology logic in Employer.model?
   CLOSED: [2018-02-15 Thu 12:09]
** DONE Verify UI Changes -> Understand schema better
   CLOSED: [2018-02-15 Thu 12:26]
*** Marketplace interviewers see schedule
*** Marketplace candidates see schedule as well 
*** DONE Hide "You have no upcoming interviews. Why not schedule some, for fun and profit?" shows for restricted?
    CLOSED: [2018-02-15 Thu 12:08]
**** Cause they'd have to pay right?
**** Maybe different "StartInterviewingOthers" as well
** DONE Frontend consumption of model changes
   CLOSED: [2018-02-15 Thu 11:59]
*** DONE Welcome
*** DONE Navbar
*** Availability
**** Interaction with practice
     |                     | HasPracticeAccess                             | Doesn't                                                                                         |
     |---------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------|
     | _CanSeeAvailability | with an org, Sees that scheduele and practice | Is just standalone, is just admin, is just company interviewer, should see just companyschedule |
     |---------------------+-----------------------------------------------+-------------------------------------------------------------------------------------------------|
     | Can't               | Sees scheule for just practice and it's clear | Doesn't see Set availability                                                                    |
** DONE Check mahesh@zenefits.com , should see schedule
   CLOSED: [2018-02-15 Thu 11:59]
* DONE Fix round selection calendars :ARCHIVE:
  CLOSED: [2018-02-21 Wed 14:30]
** DONE Cap server response
*** [[file:server/api/availability/availability.model.js::const%20availabilityList%20=%20await%20Availability.find({][This is the db query]] :ARCHIVE:
**** [[file:server/api/availability/availability.model.js::Availability.getNextAvailableTime%20=%20function(user,%20orgId)%20{][Maybe we can't just modify the query directly because this uses it too]] -> deleted
*** [[file:server/api/availability/availability.controller.js::exports.getAvailableTimes%20=%20async%20function(req,%20res)%20{][Server endpoint]]  :ARCHIVE:
*** What part of availabilities can we query against? ->  [[file:server/api/availability/availability.model.js::function%20getAllTimeSlots(user,%20userDataList,%20skipMonths)%20{][this check]]
**** Best place may be
**** Who is using MAX_WEEKS [[file:server/api/availability/availability.model.js::for%20(var%20week%20=%200;%20week%20<%20MAX_WEEKS%20+%20EXTRA_WEEKS;%20week++)%20{][here]] -> Nobody important                :ARCHIVE:
** DONE Restrict client query to stay within arrows
   CLOSED: [2018-02-20 Tue 18:00]
  [[file:client/app/schedule/available-times/available-times.directive.js::$scope.datePage%20=%20Math.min($scope.datePage,%20AvailabilityService.MAX_WEEKS)][Limit the initial location query]] 
** DONE Is there some next-available functionality [[file:client/app/schedule/available-times/available-times.directive.js:://%20datePage%20should%20always%20be%20in%20sensible%20range][that breaks?]]
   CLOSED: [2018-02-21 Wed 13:11]
   https://trello.com/c/J2mAoB8e
** DONE Do any date get caught between my additions?
   CLOSED: [2018-02-21 Wed 12:20]
** Orthogonal
*** Availabilities are augmented [[file:server/api/availability/availability.model.js::availabilityId:%20availability._id.toString(),][here]] but incremented somewhere else
**** They are also renamed, _id in the db but availabilityId in link
*** Do availabilities always have paused set to [[file:server/api/availability/availability.model.js::paused:%20{%20$in:%20%5Bnull,%20false%5D%20},][value]]?
*** I think this is the "Works at same company" [[FILe:server/api/availability/availability.model.js::let%20userList%20=%20await%20UserModel.findAllInList(userIdList);][Name better]]
**** Apparently it's a lot more
*** Does [[file:server/api/availability/availability.model.js:://Filter%20out%20the%20scores%20so%20that%20the%20client%20can't%20see%20it][filtering out the scores]] actually work?
****   [[/Users/drewlazzeri/Desktop/Screen%20Shot%202018-02-20%20at%2011.34.36%20AM.png][I don't think so...]]
**** Why do we have scores here at all?
*** What filters on the client side?
**** Must exist to explain [[/Users/drewlazzeri/Desktop/Screen Shot 2018-02-21 at 12.19.31 PM.png][this response - view pair]]    
**** Could also be timezones
*** What filters on the server?
* DONE Unmasking Email Copy change
  CLOSED: [2018-02-22 Thu 18:15]
** Test with? -> Docker 
* DONE Fix linkedin clear out
  CLOSED: [2018-02-23 Fri 14:00]
** Can we just check for null? -> [[file:client/app/admin/tabs/user/admin-user.directive.js::if%20(profile.linkedin.handle)][Yup]]
** There is a [[file:client/app/admin/tabs/user/admin-user.directive.js:://%20do%20this%20so%20it%20sets%20before%20clearbitthe %20delay%20(and%20ensure%20it%20is%20set%20after%20clearbit%20may%20overwrite)][promise]] that should prevent this behavior
*** I'll point it out in the PR, get us out of here.
** Only the admin user-directive and a script touch the linkedin part of a clearbit response
** I'm not going to test this, it's too simple
*** TJ how did you test this dude, he's not a user"""
