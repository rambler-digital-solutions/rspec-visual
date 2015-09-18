# Rspec::Visual

RSpec plugin for writing "visual" tests: tests that look for changes in the
applications's look by comparing screenshots on current branch to the latest
'stable' screenshots

## Installation and Usage

### Step 1 - Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-visual'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-visual

### Step 2 - Configuration

Configure `rspec-visual` with the folder for _"stable"_ screenshots (they will
be persisted in version control), folder for temporary screenshots, and run `capybara` setup:

```ruby
# spec/support/rspec-visual.rb
Rspec::Visual::Configuration.configure do |config|
  config.screenshot_folder = Rails.root.join('tmp')
  config.stable_screenshot_folder = Rails.root.join('docs/visual')
  config.configure_capybara
end
```

### Step 3 - Writing tests

Write some visual tests (**make sure to tag them with `visual: true`**)
using following steps:

- in your test, visit the page that you want to check
- take the screenshot using `take_screenshot` helper and passing it page and example
- use `look_like` matcher for assertion

```ruby
# spec/features/visual/home_page_spec.rb
require 'rails_helper'

describe 'home page', type: :feature, visual: true do
  it 'home_page' do |example|
    visit '/'
    take_screenshot(page, example)
    should look_like example.description
  end
end
```

### Step 4 - Checking the result

#### First run

No failures will occur. Screenshots will be saved in the "stable" folder that you
defined in "Configure" step.

#### Consequent runs

Screenshots from all "visual" tests will be matched against ones in "stable" folder.

In case there is a difference, like so:

#### "Stable" screenshot
![Original](/rambler-digital-solutions/rspec-visual/blob/screenshots-do-not-delete/sample1.jpg?raw=true "Original")

#### Screenshot with changes (banner missing)
![Actual](/rambler-digital-solutions/rspec-visual/blob/screenshots-do-not-delete/sample2.jpg?raw=true "Actual")

#### Diff file (diff area is highlighted in red)
![Diff](/rambler-digital-solutions/rspec-visual/blob/screenshots-do-not-delete/sample_diff.jpg?raw=true "Diff")

The test will fail and difference file will be generated in
`Rspec::Visual::Configuration.screenshot_folder`:

Also, failure message will say:

```shell
Failures:

  1) home page home_page
     Failure/Error: should look_like example.description
       expected /path/to/tmp/home_page.png to look like /path/to/docs/visual/home_page.png
       If you intended home_page to look diffrently, please copy over /path/to/tmp/home_page.png into /path/to/docs/visual
     # ./spec/features/visual/home_page_visual_spec.rb:10:in `block (2 levels) in <top (required)>'
```
_**Please read the failure message carefully, and if you indeed wanted the page to change
than manually copy now-correct screenshot to the "stable" folder in order for specs to pass**_

## GOTCHAS

1. depends on `rspec, capybara, poltergeist, phantomJS` and _**imagemagick**_
2. May conflict with `VCR`, to overcome use:

```ruby
VCR.configure do |c|
  c.ignore_localhost = true
end
```

3. If you want to check the app that is NOT _localhost_, use Capybara config like so:

```ruby
RSpec.configure do |config|
  default = Capybara.server_port
  config.before(:example, :visual => :true) do
    Capybara.run_server = false
    Capybara.server_port = 80
    Capybara.app_host = 'http://stage.myapp.com'
  end

  config.after(:example, :visual => :true) do
    Capybara.run_server = true
    Capybara.server_port = default
  end
end
```

## Contributing

### TODO

- add ability to take screenshots in different browsers
- add ability to take screenshots in different viewports
- add ability to configure 'similarity' percentage
- add ability to test certain areas of the page
- add test coverge
- expand beyond `poltergeist`, try `selenium-webkit`

1. Fork it ( https://github.com/[my-github-username]/rspec-visual/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
