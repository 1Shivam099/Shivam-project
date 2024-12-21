// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LearnToEarn {
    uint256 public chapterCounter;
    mapping(uint256 => string) public chapterContent;
    mapping(uint256 => address) public chapterAuthors;
    mapping(uint256 => address) public chapterOwners;

    event ChapterCreated(uint256 indexed chapterId, string content, address indexed author);
    event ChapterTransferred(uint256 indexed chapterId, address indexed from, address indexed to);

    // Constructor (no external libraries used)
    constructor() {
        chapterCounter = 0;
    }

    // Function to create a new chapter
    function createChapter(string memory content) public {
        chapterCounter++;
        uint256 chapterId = chapterCounter;

        chapterContent[chapterId] = content;
        chapterAuthors[chapterId] = msg.sender;
        chapterOwners[chapterId] = msg.sender;

        emit ChapterCreated(chapterId, content, msg.sender);
    }

    // Function to get chapter details (content and author)
    function getChapter(uint256 chapterId) public view returns (string memory content, address author) {
        return (chapterContent[chapterId], chapterAuthors[chapterId]);
    }

    // Function to transfer ownership of a chapter to another address
    function transferChapter(address to, uint256 chapterId) public {
        require(chapterOwners[chapterId] == msg.sender, "You do not own this chapter");
        chapterOwners[chapterId] = to;

        emit ChapterTransferred(chapterId, msg.sender, to);
    }

    // Function to check the owner of a chapter
    function ownerOf(uint256 chapterId) public view returns (address) {
        return chapterOwners[chapterId];
    }
}
