module Org exposing (source)

source = """* EventReg
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
https://terezka.github.io/line-charts/"""
