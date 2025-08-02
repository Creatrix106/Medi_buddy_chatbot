const messageInput = document.querySelector(".message-input");
const chatbody = document.querySelector(".chat-body");
const sendMessagButton = document.querySelector("#send-message");

const userData = {
    message: null
}

const createMessageElement = (content,...classes) => {
    const div = document.createElement("div");
    div.classList.add("message",...classes);
    div.innerHTML = content;
    return div;

}

const MediBotResponse = async (incomingMessageDiv) => {
    const messageElement = incomingMessageDiv.querySelector(".message-text");


    const requestOptions = {
        method: 'POST',
        headers: { 'Content-Type': 'application/json'},
        body: JSON.stringify({ message: userData.message })
    }

    
    try{
        const response = await fetch('/userinput', requestOptions);
        const data = await response.json();
        if(!response.ok) throw new Error(data.error || 'Failed to get response');
        BotReply = data.flaskResponse.response;
        messageElement.innerText = BotReply;
        console.log('Bot Reply:', BotReply);

    } catch (error) {
        console.log("Error getting bot response:", error);
        messageElement.innerText = "Sorry, I'm having trouble responding right now. Please try again.";
    }
}

const handleOutGoingMessage = (e) => {
    e.preventDefault();
    userData.message = messageInput.value.trim()
    messageInput.value = "";

    const messageContent = `<div class="message-text"></div>`;
    const OutgoingMessageDiv = createMessageElement(messageContent,"user-message");
    OutgoingMessageDiv.querySelector('.message-text').textContent = userData.message;
    chatbody.appendChild(OutgoingMessageDiv);
    setTimeout(() => {
        const messageContent = `<div class="vegito"></div>
        <div class="message-text">
        <div class="thinking-indicator">
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
        </div>
        </div>`
        const incomingMessageDiv = createMessageElement(messageContent,"bot-message", "thinking");
        chatbody.appendChild(incomingMessageDiv);
        MediBotResponse(incomingMessageDiv);
    }, 600);
}

messageInput.addEventListener("keydown",(e) => {
    const userMessage = e.target.value.trim();
    if(e.key === "Enter" && userMessage) {
        handleOutGoingMessage(e);
    }
})

sendMessagButton.addEventListener("click", (e) => handleOutGoingMessage(e));



const startBot = document.querySelector('.start-bot')
const chatpopup = document.querySelector('.chatbot-popup')
const exitBot = document.querySelector('#chat-tab-popup')

startBot.addEventListener('click', ()=>{
    chatpopup.style.display = 'block'
    startBot.style.display = 'none'
    startBot.style.boxShadow = 'none'
})

exitBot.addEventListener('click',()=>{
    chatpopup.style.display = 'none';
    startBot.style.display = 'block'
    startBot.style.boxShadow = '0px 0px 10px rgba(0, 0, 0, 0.2), 0px 0px 20px rgba(0, 0, 0, 0.2)'
})