module TracksHelper
  def ugly_lyrics(lyrics)
    noted_lyrics = lyrics.split("\n").map do |line|
      "&#9835; #{h(line)}"
    end.join("\n")

    "<pre>#{noted_lyrics}</pre>".html_safe
  end
end
