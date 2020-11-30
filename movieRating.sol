//SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0 <0.8.0;

pragma experimental ABIEncoderV2;

contract movieRatingContract{
    mapping(string => uint32) private movieRatingsRecieved;
    mapping(string => bool) private movieExists;
    string[] private movieList;
    address owner;
    
    constructor () {
        owner = msg.sender;
    }
    
    modifier mCheckOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function addNewMovie(string memory _movie) public mCheckOwner {
        require(!movieExists[_movie], "Same movie already added in the network.");
        movieList.push(_movie);
        movieExists[_movie] = true;
    }
    
    function viewMovies() public view returns(string[] memory){
        return movieList;
    }
    
    function getMovieRating(string memory _movie) public view returns (uint32){
        require(movieExists[_movie], "Movie doesn't exist. Please check and try again.");
        return movieRatingsRecieved[_movie];
    }
    
    function rateMovie(string memory _movie) public {
        require(movieExists[_movie], "Movie doesn't exist. Please check and try again.");
        movieRatingsRecieved[_movie]++;
    }
}
