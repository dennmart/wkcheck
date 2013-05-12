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

Once the API Key is saved, simply run `wkcheck` to see how many lessons and reviews you have pending in WaniKani.

```
$ wkcheck
You have no lessons pending.
You have 93 reviews pending.
```

If you don't have any lessons or reviews pending, you'll be able to see when your next review will come up.

```
$ wkcheck
You have no lessons or reviews now! You'll have some more on Sunday, May 10 at 8:45 AM.
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
