Add-Type -AssemblyName PresentationFramework
class Window 
{
    [System.Windows.Window]$window
    [System.Windows.Controls.Button]$button
    [int]$count = 0

    Window()
    {
        [xml]$xaml = @"
        <Window
            xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
            xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
            x:Name="Window"
            Title="C#Shell!">
            <Grid x:Name="Grid">
                <Grid.RowDefinitions>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="100"/>
                </Grid.RowDefinitions>
                
                <ListView x:Name="List" />
                <Button x:Name="AddButton" Content="Add" Grid.Row="1"/>
            </Grid>
        </Window>
"@
        $reader = [System.Xml.XmlNodeReader]::new($xaml)
        $this.window = [System.Windows.Markup.XamlReader]::Load($reader)
        $this.button = $this.window.FindName("AddButton")
        $this.button.Add_Click({
            $self = Get-Variable -Scope 1 -ValueOnly this
            $self.window.FindName("List").Items.Add("Item" + ($self.count++).ToString())
        })
        $this.window.ShowDialog()
    }
}

$window = [Window]::new()