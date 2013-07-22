if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all

  # workaround for login bug: https://github.com/josevalim/rails-footnotes/issues/25
  Footnotes::Filter.notes -= [:cookies]
end