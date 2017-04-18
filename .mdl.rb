# Markdown style preferences for mdl
# https://github.com/mivok/markdownlint/blob/master/docs/creating_styles.md

# Start by including all rules
all

# First header should be a top level header
exclude_rule 'MD002'

# Hard tabs
exclude_rule 'MD010'

# Line length
exclude_rule 'MD013'

# Dollar signs used before commands without showing output
exclude_rule 'MD014'

rule 'MD029', :style => 'ordered'

# Trailing punctuation in header
exclude_rule 'MD026'

# Inline HTML
exclude_rule 'MD033'

# Emphasis used instead of a header
exclude_rule 'MD036'

# First line in file should be a top level header
exclude_rule 'MD041'