# POP v.s. IMAP

source: <https://github.com/trimstray/test-your-sysadmin-skills#simple-questions>

POP and IMAP are both protocols for retrieving messages from a mail server to a mail client.

POP (Post Office Protocol) uses a one way push from mail server to client. By default this will send messages to the POP mail client and remove them from the mail server, though it is possible to configure the mail server to retain all messages. Any actions you take on the message in your mail client (labeling, deleting, moving to a folder) will not be reflected on the mail server, and thus inaccessible to other mail clients pulling from the mail server. POP uses little storage space on the mail server and can be seen as more secure since messages only exist on one mail client instead of the mail server and multiple clients.

IMAP (Internet Message Access Protocol) uses two way communication between mail server and client. Deleting or labeling a message in your mail client configured with IMAP will also delete or label the message on the mail server. IMAP allows for a similar experience when accessing mail across different clients or devices since messages can existing in the same state across multiple devices. IMAP can also save disk space on the mail client by selectively syncing messages, deleting older messages from the mail client since it can sync them from the mail server later as needed.

Choose IMAP if you need to access messages across multiple devices and you want to save disk space on your client device. Choose POP if you want to save disk space on your mail server, only access messages from one client device, and ensure that messages do not exist on multiple systems.
