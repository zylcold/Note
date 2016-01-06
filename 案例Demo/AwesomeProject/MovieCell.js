'use strict'
var React = require('react-native');
var {
	Image,
	StyleSheet,
	Text,
	View,
	Component
} = React;

class MovieCell extends Component {
	render() {
		return (
			<View style={styles.container}>
				<Image 
					source={{uri: this.props.movie.posters.thumbnail}}
					style={styles.thumbnail}/>
				<View style={styles.rightContainer}>
					<Text style={styles.title}>{this.props.movie.title}</Text>
					<Text style={styles.year}>{this.props.movie.year}</Text>
				</View>
			</View>
		);
	}
}

var styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  rightContainer: {
  	flex: 1,
  },
  title: {
  	fontSize: 20,
  	marginBottom: 8,
  	textAlign: 'center',
  },
  year: {
  	textAlign: 'center',
  },
  thumbnail: {
    width: 53,
    height: 81,
  },
});
module.exports = MovieCell;