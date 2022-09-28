# Little Esty Shop - [Tom Musselman](https://github.com/musselmanth)

## Links

[GitHub Repository](https://github.com/musselmanth/little-esty-shop)

[Deployed on Heroku](https://little-esty-tm.herokuapp.com/)

## Background and Description

"Little Esty Shop" is a project that required building a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices. Originally started as a group project, this version of the project is a complete refactor of the group project with added features.

## Learning Accomplishments

- Designed a normalized database schema and organized model relationships
- Utilized advanced active record techniques to perform complex database queries
- Utilized advanced routing techniques including namespacing to organize and group like functionality together.
- Practice consuming a public API

## Technology Used

- Rails 5.2.x
- Ruby 2.7.4
- PostgreSQL

## Setup

To set up the app use the following steps:

1. Clone the repository.
2. Navigate your terminal to the root directory and run `bundle install`
3. Run `rails db:{create,migrate}`
4. To seed the database with data from the provided csv files, run the rake task `rails csv_load:all`
5. Run `rails server` to view the app in your brower at `localhost:3000`

## Database Setup

![Screen Shot 2022-09-27 at 5 40 51 PM](https://user-images.githubusercontent.com/25420663/192656265-04a3fdbc-0111-4a23-83f1-a5e5af5b7e74.png)
