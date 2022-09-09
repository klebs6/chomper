crate::ix!();

pub fn maybe_adjust_range(file: &SourceFile, range: TextRange) -> Option<TextRange> {

    let syntax = file.syntax();
    let text   = syntax.text().slice(range.start()..);

    let mut acc: TextSize = range.start();

    let nonws_pos = match text.try_for_each_chunk(|chunk| {

        if let Some(pos) = chunk.find(|c| !char::is_whitespace(c)) {
            let pos: TextSize = (pos as u32).into();
            return Err(acc + pos);
        }

        acc += TextSize::of(chunk);

        Ok(())
    })
    {
        Ok(_)    => range.start(),
        Err(pos) => pos,
    };

    // -----------------------------------
    let range = if range.is_empty() {

        let end = match text.find_char('\n') {
            None      => return None,
            Some(end) => end.checked_sub(TextSize::from(1)).unwrap_or(TextSize::from(0)),
        };

        TextRange::new(nonws_pos, range.end() + end)

    } else {

        tracing::info!("nonws_pos   {:?}", nonws_pos);
        tracing::info!("range.end() {:?}", range.end());

        /* TODO: problem is we need to chomp the last \n, not the first
        let end_offset = match text.find_char('\n') {
            None             => range.len(),
            Some(end_offset) => end_offset,//end_offset.checked_sub(TextSize::from(1)).unwrap_or(range.len()),
        };

        TextRange::new(nonws_pos, range.start() + end_offset)
        */

        // mostly, the minus 1 at the end is
        // acceptable because it usually trims off
        // the newline
        TextRange::new(nonws_pos, range.end() - TextSize::from(1))
    };

    Some(range)
}
