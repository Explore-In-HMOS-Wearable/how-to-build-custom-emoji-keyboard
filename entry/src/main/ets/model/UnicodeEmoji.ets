export interface EmojiCategory {
  title: string;
  emojis: string[];
}

interface EmojiRange {
  title: string;
  start: number;
  end: number;
}

const UNICODE_RANGES: EmojiRange[] = [
  { title: 'Smileys',  start: 0x1F600, end: 0x1F64F },
  { title: 'Symbols',  start: 0x1F300, end: 0x1F5FF },
  { title: 'Transport',start: 0x1F680, end: 0x1F6FF },
  { title: 'Supplem',  start: 0x1F900, end: 0x1F9FF },
  { title: 'Extended', start: 0x1FA70, end: 0x1FAFF },
  { title: 'Dingbats', start: 0x2600,  end: 0x27BF  }
];

const VS16: string = '\uFE0F';

const RE_PRESENTATION: RegExp = new RegExp('^\\p{Emoji_Presentation}$', 'u');
const RE_EMOJI: RegExp        = new RegExp('^\\p{Emoji}$', 'u');
const RE_COMPONENT: RegExp    = new RegExp('^\\p{Emoji_Component}$', 'u');

export function getCategorizedEmojis(): EmojiCategory[] {
  const result: EmojiCategory[] = [];

  for (let i = 0; i < UNICODE_RANGES.length; i++) {
    const range: EmojiRange = UNICODE_RANGES[i];
    const emojis: string[] = [];

    for (let cp = range.start; cp <= range.end; cp++) {
      const ch: string = String.fromCodePoint(cp);

      if (RE_COMPONENT.test(ch)) {
        continue;
      }

      if (RE_PRESENTATION.test(ch)) {
        emojis.push(ch);
      } else if (RE_EMOJI.test(ch)) {
        emojis.push(ch + VS16);
      }
    }

    result.push({ title: range.title, emojis: emojis });
  }

  return result;
}

export const CATEGORIZED_EMOJIS: EmojiCategory[] = getCategorizedEmojis();