[![Build Status](https://travis-ci.org/dennmart/wkcheck.png)](https://travis-ci.org/dennmart/wkcheck) [![Code Climate](https://codeclimate.com/github/dennmart/wkcheck.png)](https://codeclimate.com/github/dennmart/wkcheck)

**wkcheck** is a command-line tool to access information from your [WaniKani](http://www.wanikani.com/) account.

## Installation
```
$ gem install wanikani
```

## API Key

Before using wkcheck, you need to set up the WaniKani API key from your account. You need to use the `--api-key` flag to save your API Key for future use. This only needs to be done once. A file will be created in `~/.wkcheck.yml` with your API Key. The key can be found in your [account settings](http://www.wanikani.com/account).

```
$ wkcheck --api-key=YOUR_WANIKANI_API_KEY
```

## Usage

Once the API Key is saved, you can check fetch different types of information from your WaniKani account (run `wkcheck` to see the different options).

### Current study queue

Displays how many new lessons and current reviews you have pending.

```
$ wkcheck -q
You have no lessons pending.
You have 93 reviews pending.
```

If you don't have any lessons or reviews pending, you'll be able to see when your next review will come up.

```
$ wkcheck -q
You have no lessons or reviews now! You'll have some more on Sunday, May 10 at 8:45 AM.
```

### Current level progression

Displays the number of radicals and kanji that have passed 'Apprentice' status for your current level.

```
$ wkcheck -l
Your progress for level 18:
0 out of 8 Radicals (0.0%)
2 out of 29 Kanji (6.9%)
```

### Critical items

Displays your current criticals under a certain percentage of correctness (default: 75).

```
$ wkcheck -c
Your Critical Items - Max percentage: 75 (Kanji, Radicals, Vocabulary):
了 (りょう) - finish, complete, end
感覚 (かんかく) - senses, the senses
```

You can also specify an integer to change the max percentage of correctness.

```
$ wkcheck -c 85
Your Critical Items - Max percentage: 85 (Kanji, Radicals, Vocabulary):
栄 (えい) - prosperity, flourish
署 (しょ) - government office, political office, office
隹 - turkey
去 - cemetery
上がる (あがる) - to rise
商売 (しょうばい) - business, commerce
```

### Random Kanji / Random Word

Displays information for a random kanji or word from WaniKani's database. It goes through all levels, not just
your current level.

```
$ wkcheck -k
Your random kanji is 肌
Level: 45
Meaning: skin
Reading (kunyomi): はだ
```

```
$ wkcheck -w
Your random word is 彩る
Level: 48
Meaning: to color something, to colour something, to color, to colour
Reading: いろどる
```

## Contributing

I'll be super-happy if you guys help giving back! If you want to do some hacking on wkcheck for your needs, this is a good guideline to get started:

* Fork the repo on GitHub
* Create a branch on your clone that will contain your changes
* Hack away on your branch
* Add tests in the `/features` or `/test` directory relating to your changes
* Make sure all tests still pass (`rake test_all`)
* If you're adding new functionality, make sure to update `README.md`
* Push the branch to GitHub
* Send me a pull request for your branch
