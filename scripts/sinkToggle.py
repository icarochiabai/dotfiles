import subprocess
import os

sinks = subprocess.run("pactl list short sinks", shell=True, capture_output=True, text=True).stdout

sinks = sinks.split("\n")

class Sink:
    def __init__(self, id, state):
        self.id = id
        self.state = state

    def toggle(self):
        if self.state:
            self.state=False
        else:
            self.state=True
    def __str__(self):
        return "Sink " + self.id + " is currently " + str(self.state)

def toggle_sink(sinks):
    current_sink = None
    next_sink = None

    for i in range(len(sinks)):
        if sinks[i].state:
            current_sink = sinks[i]
            next_sink = sinks[(i + 1)%len(sinks)]

    if current_sink.id != next_sink.id:
        os.system("pactl set-default-sink " + next_sink.id)
        os.system("dunstify 'Áudio' 'A saída de áudio acaba de ser alterada.'")

new_sinks = []
for sink in sinks:
    if sink == '':
        continue
    else:
        sink_data = sink.split("\t")

        new_sink = Sink(sink_data[0], True if sink_data[-1] != "SUSPENDED" else False)
    new_sinks.append(new_sink)

toggle_sink(new_sinks)
