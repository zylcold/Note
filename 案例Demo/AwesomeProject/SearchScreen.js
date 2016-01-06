var REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-native/master/docs/MoviesExample.json';
var React = require('react-native');
var MovieCell = require('./MovieCell');
var MOCKED_MOVIES_DATA = [
  {title: 'Title', year: '2015', posters: {thumbnail: 'http://i.imgur.com/UePbdph.jpg'}},
];
var {
  AppRegistry,
  Image,
  ListView,
  StyleSheet,
  Text,
  View,
  Component
} = React;

class SearchScreen extends Component {

	constructor(props) {
		super(props);
		this.state = {
			dataSource: new ListView.DataSource({
				rowHasChanged:(row1, row2)=> row1 !== row2,
			}),
			loaded: false,
		}
	}
	//在组件被加载之后，componetDidMount 是React组件里面只会点用一次的函数
	componentDidMount() {
		this.fetchData();
	}
	fetchData() {
		fetch(REQUEST_URL)
		.then((response)=>response.json())
		.then((responseData)=> {
			this.setState({
				dataSource: this.state.dataSource.cloneWithRows(responseData.movies),
				loaded: true,
			});
		}).done();
	}
	render() {
		if(!this.state.loaded) {
			return this.renderLoadingView();
		}
		return (
			<ListView 
				dataSource={this.state.dataSource}
				renderRow={this.renderRow}
				style={styles.listView} />
		);
	}
	renderLoadingView() {
		return (
			<View style={styles.container}>
				<Text>
					Loading movie...
				</Text>
			</View>
		);
	}
	renderRow(movie: Object, sectionID: number | string, rowID: number | string) {
		return (
			<MovieCell 
				key={movie.id}
				movie={movie} />
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
  listView: {
  	paddingTop: 64,
  	backgroundColor: '#F5FCFF'
  },
});

module.exports = SearchScreen;
