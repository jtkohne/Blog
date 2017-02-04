import { Meteor } from "meteor/meteor";

export class BlogSettings {

  constructor(props) {
    // super(props);
    this.settings = this.settings.bind(this);
  }

  settings() {
    const { settings } = this.props;

    return [{
      "postsPerPage": 4,
      "featuredPosts": []
    }]
  }
}
